class TicketMailer < ActionMailer::Base
  default from: Figaro.env.mail_sender
  
  def send_notification(ticket)
    @ticket = ticket
    mail(to: @ticket.user.email,  subject: "Ticket: #{@ticket.name} has been updated!") 
  end
  
  def new_ticket(ticket)
    @ticket = ticket
     mail(from: @ticket.user.email, to: Figaro.env.mail_sender, subject: "New ticket: #{@ticket.name} [#{@ticket.project.name}]") 
  end


end
