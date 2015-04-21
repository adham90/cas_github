require 'omniauth'
require 'omniauth-github'
class APP < Grape::API

  use Rack::Session::Cookie
  default_format :json
  format :json
  formatter :json, Grape::Formatter::Rabl

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end
  
  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist", provider_ignores_state: true
  end

  get '/', rabl: "/hi" do
    @user = User.all
  end

  resource :auth do
    get '/github' do
    end

    get '/github/callback' do
      auth = env['omniauth.auth']
      serveice = CasGithub::Services::Signup.new email: auth[:info][:email], name: auth[:info][:name], uid: auth[:uid], username: "adham", avatar_url: "url"
      serveice.call
      redirect "/"
      if serveice.status == :ok
        redirect "/"
      end      
    end
  end

end