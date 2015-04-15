ENV["GCAS_ENV"] ||= "development"

require "bundler/gem_tasks"
require "active_record"

namespace :db do
  desc "Creates the tables for peter to work with."
  task :migrate do
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: "db/#{ENV["GCAS_ENV"]}.sqlite3"
    )
    ActiveRecord::Migrator.migrate(File.expand_path('../lib/cas_github/migrations', __FILE__))
  end
end
