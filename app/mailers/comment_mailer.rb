class CommentMailer < ActionMailer::Base
  default from: Figaro.env.mail_sender
  
  def new_comment(comment)
    @comment = comment
    mail(to: @comment.ticket.user.email,  subject: "New comment on ticket: #{@comment.ticket.name}") 
  end


end
