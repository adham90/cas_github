class App < Sinatra::Base
  enable :sessions

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"
    provider :developer
  end

  %w(get post).each do |method|
    send(method, "/auth/:provider/callback") do
      auth = env['omniauth.auth']
      serveice = CasGithub::Services::Signup.new email: auth[:info][:email], name: auth[:info][:name], uid: auth[:uid], username: "adham", avatar_url: "url"
      serveice.call

      if serveice.status == :ok
        redirect "/"
      end
    end
  end


  get "/" do
    "Hello, world"
  end
end
