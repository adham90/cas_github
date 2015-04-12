require "spec_helper"

module CasGithub::Services
  describe Signup do
    attr_reader :service

    before :each do
      @service = Signup.new(email: "me@example.com", uid: "123", username: "user1", name: "adham", avatar_url: "http://example.com/avatar.png")
      service.call
    end

    it "saves the user" do
      expect(service.user.id).to_not eq nil
    end

    it "has a created_at timestamp" do
      expect(service.user.created_at).to be < Time.now
    end

    it "signs a user up and return :ok status" do
      expect(service.status).to be :ok
    end
  end
end
