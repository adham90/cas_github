require "spec_helper"

module CasGithub::Services
  describe Signup do
    before :each do
      @service = Signup.new(email: "me@example.com", password: "password")
      service.call
    end

    it "encrypts the password" do
      
    end

    it "doesn't allow the password to be seen again" do
      
    end
  end
end
