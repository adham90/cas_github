require 'omniauth'
require 'omniauth-github'

module CasGithub::API
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
      provider :github, 'Client_ID', 'Client_Secret', scope: "user,repo,gist", provider_ignores_state: true
    end

    get '/', rabl: "/hi" do
      @user = User.all
    end

    get '/login/' do
      if TicketGrantingTicket.where(name: cookies[:CASTGT]).first
        service = CasGithub::Services::Login.new ticket_granting_ticket_name: cookies[:CASTGT]
        service.call
        if params[:service]
          redirect params[:service] + "?ticket=#{service.service_ticket.name}"
        end
      else
        if params[:service]
          @@service = params[:service]
          redirect "/auth/github"
        else
          422
        end
      end
    end

    resource :auth do
      
      get '/github' do
      end

      get '/github/callback' do
        if @@service != ""
          auth = env['omniauth.auth']
          @user = User.where(uid: auth[:uid]).first
          if @user

            service = CasGithub::Services::Login.new(
              uid: auth[:uid],
              service: @@service
            )
            service.call

          else
            serveice = CasGithub::Services::Signup.new email: auth[:info][:email], name: auth[:info][:name], uid: auth[:uid], username: "adham", avatar_url: "url"
            serveice.call
          end
          
          if service.status == :ok
            request.cookies[:CASTGT] = service.ticket_granting_ticket.name
            redirect @@service + "?ticket=#{service.service_ticket.name}"
          end
        else
          422
        end
      end

    end

  end
end