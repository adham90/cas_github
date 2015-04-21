require 'omniauth'
require 'omniauth-github'
class APP < Grape::API

  use Rack::Session::Cookie
  default_format :json
  format :json
  formatter :json, Grape::Formatter::Rabl

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']#, provider_ignores_state: true
  end

  get '/', rabl: "/hi" do
    { hello: "world" }
  end

  resource :auth do
    %w(get post).each do |method|
      send(method, "/:provider/callback") do
        auth = env['omniauth.auth']
        serveice = CasGithub::Services::Signup.new email: auth[:info][:email], name: auth[:info][:name], uid: auth[:uid], username: "adham", avatar_url: "url"
        serveice.call

        if serveice.status == :ok
          redirect "/"
        end
      end
    end
  end
  
end