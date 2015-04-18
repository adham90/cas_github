$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "bundler"
Bundler.require
require 'cas_github'


ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/test.sqlite3"
)

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  def spawn_user email: "me@example.com", username: "user", name: "name", 
    uid: "uid", avatar_url: "avatar_url"

    service = CasGithub::Services::Signup.new(email: email,
                                              username: username,
                                              name: name,
                                              uid: uid,
                                              avatar_url: avatar_url
                                             )

    service.call
    service.user
  end

  def spawn_login_ticket
    service = CasGithub::Services::Login.new
    service.call
    service.ticket
  end

  def spawn_ticket_granting_ticket user: nil
    tgt = TicketGrantingTicket.new name: "TGT-#{Digest::SHA1.hexdigest(Time.new.to_s)}", user: user
    tgt.save
    tgt
  end

  def spawn_service_ticket service: nil, user: nil
    st = ServiceTicket.new service: service, name: "ST-#{Digest::SHA1.hexdigest(Time.new.to_s)}", user: user
    st.save
    st
  end
end
