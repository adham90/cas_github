require "spec_helper"

module CasGithub::Services
  describe Login do
    let(:user) {spawn_user}

    it "generates a login ticket for a fresh login attempt" do
      service = Login.new
      service.call
      expect(service.ticket).to be_kind_of LoginTicket
    end

    it "logs a user in based off an existing session" do

    end

    it "provides a service ticket based off a ticket granting cookie auth attempt" do

    end

    context "given an existing login ticket" do
      attr_reader :login_ticket

      before do
        @login_ticket = spawn_login_ticket
      end

      it "expires a login ticket after an unsuccessful auth attempt" do
        lt = login_ticket.name
        service = Login.new(
          uid: "bad_uid",
          login_ticket_name: lt,
          service: "https://app.example.com"
        )
        service.call
        expect(login_ticket.reload).to_not be :active?
      end

    end
  end

end
