class TicketMailer < ActionMailer::Base
  default from: Figaro.env.mail_sender
  
  def send_notification(ticket)
    @ticket = ticket
    mail(to: @ticket.user.email,  subject: "Ticket: #{@ticket.name} has been updated!") 
  end


end
