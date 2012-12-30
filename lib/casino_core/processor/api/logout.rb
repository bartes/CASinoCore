require 'casino_core/processor'
require 'casino_core/helper'
require 'casino_core/model'

# The Logout processor should be used to process API DELET requests to /cas/v1/tickets/TGT-fdsjfsdfjkalfewrihfdhfaie
class CASinoCore::Processor::API::Logout < CASinoCore::Processor
  include CASinoCore::Helper::TicketGrantingTickets

  # This method will call `#user_logged_out_via_api`
  #
  # @param [String] ticket_granting_ticket Ticket granting ticket to logout
  def process(ticket_granting_ticket)
    @user_ticket_granting_ticket = ticket_granting_ticket

    fetch_ticket_granting_ticket
    handle_ticket_granting_ticket
    callback_user_logged_out
  end

  def fetch_ticket_granting_ticket
    @ticket_granting_ticket = find_valid_ticket_granting_ticket(@user_ticket_granting_ticket, nil)
  end

  def handle_ticket_granting_ticket
    remove_ticket_granting_ticket(@ticket_granting_ticket) if @ticket_granting_ticket
  end

  def callback_user_logged_out
    @listener.user_logged_out_via_api
  end

end
