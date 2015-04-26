require 'spec_helper'

module CasGithub::API
  describe APP, :type => :controller do
    include Rack::Test::Methods

    let(:app){APP}
    let(:username){"username"}
    let(:uid){"uid"}
    let(:service){"https://app.example.com"}

    before{clear_cookies}


    # describe "GET '/auth/github/callback'" do
    #   before(:each) do
    #     valid_github_login
    #     env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    #     get "auth/github/callback"
    #   end

    #   it "should set user_id" do
    #     expect{get "/github/callback"}.to change{User.count}.by(1)
    #   end
    # end

    describe "#login" do

      it "has to redirect to github" do
        get "/login/service"
        expect(last_response.location).to eq('/auth/github')
      end

      it "allow user to signup" do
        skip
        expect{get "/github/callback"}.to change{User.count}.by(1)
      end

    end
  end
end
