class TicketMailer < ActionMailer::Base
  default from: Figaro.env.mail_sender
  
  def send_notification(ticket, recipient = nil)
    @ticket = ticket
    if recipient.nil?
      recipient = @ticket.user.email
    end
    mail(to: recipient,  subject: "Ticket: #{@ticket.name} has been updated!") 
  end
  
  def new_ticket(ticket, recipient = nil)
    @ticket = ticket
    if recipient.nil?
      recipient = Figaro.env.mail_sender
    end
     mail(from: Figaro.env.mail_sender, to: recipient, subject: "New ticket: #{@ticket.name} [#{@ticket.project.name}]") 
  end


  

end
