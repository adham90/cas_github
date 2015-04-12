module CasGithub::Services
  class Signup
    attr_reader :user, :status

    def initialize(email:, uid:, username:, name:, avatar_url:)
      @email = email
      @uid = uid
      @username = username
      @name = name
      @avatar_url = avatar_url
    end

    def call
      @user = User.new email: @email
      @user.uid = @uid
      @user.username = @username
      @user.name = @name
      @user.avatar_url = @avatar_url
      if @user.save
        @status = :ok
      end
    end
  end
end
