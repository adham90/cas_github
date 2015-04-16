module CasGithub::Services
  class Login
    attr_reader :ticket, :ticket_granting_ticket, :service_ticket

    def initialize uid: nil, login_ticket_name: nil, service: nil
      @uid = uid
      @login_ticket_name = login_ticket_name
      @service = service
    end

    def call
      if @uid.nil?
        generate_login_ticket
      else
        login
      end
    end

  private
    def generate_login_ticket
      @ticket = LoginTicket.new name: "LT-#{Digest::SHA1.hexdigest(Time.new.to_s)}"
      @ticket.save
    end

    def login
      if valid_auth?
        generate_ticket_granting_ticket
        generate_service_ticket
      end

      expire_login_ticket
    end

    def valid_auth?
      User.find_by_uid(@uid)
    end

    def expire_login_ticket
      LoginTicket.find_by_name(@login_ticket_name).update_attribute(:active, false)
    end

    def generate_ticket_granting_ticket
      @ticket_granting_ticket = TicketGrantingTicket.new name: "TGT-#{Digest::SHA1.hexdigest(Time.new.to_s)}"
      @ticket_granting_ticket.save
    end

    def generate_service_ticket
      @service_ticket = ServiceTicket.new name: "ST-#{Digest::SHA1.hexdigest(Time.new.to_s)}"
      @service_ticket.save
    end
  end
end