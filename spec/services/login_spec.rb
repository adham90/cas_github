require "spec_helper"
require 'logger'

module CasGithub::Services
  describe Login do
    let(:user) {spawn_user}

    let(:log) { 
      Logger.new('tests.log', 'daily').tap { |l| l.level = Logger::DEBUG }
    }

    it "generates a login ticket for a fresh login attempt" do
      service = Login.new
      service.call
      expect(service.ticket).to be_kind_of LoginTicket
    end

    it "logs a user in based off an existing session" do
      ticket_granting_ticket = spawn_ticket_granting_ticket user: user
      service = Login.new(
        ticket_granting_ticket_name: ticket_granting_ticket.name,
        service: "https://app.example.com"
      )
      service.call
      expect(service.status).to eq :ok
    end

    it "provides a service ticket based off a ticket granting cookie auth attempt" do
      ticket_granting_ticket = spawn_ticket_granting_ticket user: user
      service = Login.new(
        ticket_granting_ticket_name: ticket_granting_ticket.name,
        service: "https://app.example.com"
      )
      service.call
      expect(service.service_ticket).to be_kind_of ServiceTicket
    end

    context "given an existing login ticket" do
      attr_reader :login_ticket

      before do
        @login_ticket = spawn_login_ticket
        spawn_user
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

      it "active login ticket after an successful auth attempt" do
        lt = login_ticket.name
        service = Login.new(
          uid: "uid",
          login_ticket_name: lt,
          service: "https://app.example.com"
        )
        service.call
        expect(login_ticket.active).to be true
      end

      it "generates a ticket granting ticket after a successful auth attempt" do
        lt = login_ticket.name
        service = Login.new(
          uid: "uid",
          login_ticket_name: lt,
          service: "https://app.example.com"
        )
        service.call
        expect(service.ticket_granting_ticket).to be_kind_of TicketGrantingTicket
      end

      it "generates a service ticket after a successful auth attempt" do
        lt = login_ticket.name
        service = Login.new(
          uid: "uid",
          login_ticket_name: lt,
          service: "https://app.example.com"
        )
        service.call
        expect(service.service_ticket).to be_kind_of ServiceTicket
      end
    end
  end
end
