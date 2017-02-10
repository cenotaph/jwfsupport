class CommentMailer < ActionMailer::Base
  default from: Figaro.env.mail_sender
  
  def new_comment(comment, recipient = nil)
    @comment = comment
    if recipient.nil?
      recipient = @comment.ticket.user.email
    end
    mail(to: recipient,  subject: "New comment on ticket: #{@comment.ticket.name}") 
  end


end
