require "spec_helper"

module CasGithub::Services
  describe Signup do
    attr_reader :service

    before :each do
      @service = Signup.new(email: "me@example.com", uid: "123", username: "user1", name: "adham")
      service.call
    end

    it "saves the user" do
      expect(service.user.id).to_not eq nil
    end
  end
end
