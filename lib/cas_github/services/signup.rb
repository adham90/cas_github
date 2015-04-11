module CasGithub::Services
  class Signup
    attr_reader :email, :uid, :username, :name, :user
    
    def initialize(email: "me@example.com", uid: "123", username: "user1", name: "name")
      @email = email
      @uid = uid
      @username = username
      @name = name
    end

    def call
      @user = User.new email: @email
      @user.uid = @uid
      @user.username = @username
      @user.name = @name
      @user.save
    end
  end
end