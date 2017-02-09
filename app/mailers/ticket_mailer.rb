class TicketMailer < ActionMailer::Base
  default from: Figaro.env.mail_sender
  
  def send_notification(ticket, recipient = nil)
    @ticket = ticket
    if recipient.nil?
      recipient = @ticket.user.email
    end
    mail(to: recipient,  subject: "Ticket: #{@ticket.name} has been updated!") 
  end
  
  def new_ticket(ticket)
    @ticket = ticket
     mail(from: Figaro.env.mail_sender, to: Figaro.env.mail_sender, subject: "New ticket: #{@ticket.name} [#{@ticket.project.name}]") 
  end


end
