class CommentsController < ApplicationController
  
  
  before_filter :authenticate_user!
  
  def create
    c = Comment.new(comment_params)
    if params[:ticket_id]
      @master = Ticket.find(params[:ticket_id])
    end
    @master.comments << c
    
    if @master.save!
      flash[:notice] = 'Your comment was added.'
      if params[:comment][:send_email] == "1"
        CommentMailer.new_comment(c).deliver_now
      end
    else
      flash[:error] =  'There was an error saving your comment.'
    end
    redirect_to  @master
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    parent = @comment.item
    if can? :destroy, @comment
      @comment.destroy
      flash[:notice] = 'Your comment has been deleted.'
    else
      flash[:error] = ' You do not have permission to delete this comment.'
    end
    redirect_to parent
  end
  
  protected
  
  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :content, :description, :attachment, :screenshot, :commit_hash)
  end
  
end