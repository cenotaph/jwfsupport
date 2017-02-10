class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:landing]
  
  has_scope :closed, type: :boolean
  has_scope :opened, type: :boolean
  
  def index

    if current_user.has_role? :admin
      @tickets = apply_scopes(Ticket).all.order(created_at: :desc)
      @opened_count = Ticket.opened.size
      @closed_count = Ticket.closed.size
      @total_count = Ticket.all.size
    else
      @tickets = apply_scopes(Ticket.includes(:project => :users).where('projects_users.user_id'  => current_user.id )).all.sort_by(&:created_at).reverse
      @opened_count = Ticket.includes(:project => :users).where('projects_users.user_id'  => current_user.id ).opened.size
      @closed_count = Ticket.includes(:project => :users).where('projects_users.user_id'  => current_user.id ).closed.size
      @total_count = Ticket.includes(:project => :users).where('projects_users.user_id'  => current_user.id ).size
    end
    @progress = (Ticket.closed.size.to_f / Ticket.all.size.to_f).to_f * 100

  end


  def landing
    
  end
  # GET /tickets/1
  def show
    @progress_project = (@ticket.project.tickets.closed.size.to_f / @ticket.project.tickets.size.to_f).to_f * 100
    unless @ticket.project.users.include?(current_user) || current_user.has_role?(:admin) 
      flash[:error] = 'You do not have permission to view this ticket.'
      redirect_to '/'
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      TicketMailer.new_ticket(@ticket).deliver_now
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tickets/1
  def update

    if @ticket.update_attributes(ticket_params)
      comment_text = []

      if @ticket.previous_changes.keys.include?("status")
        comment_text << 'status: ' + @ticket.status_line 
      end
      if @ticket.previous_changes.keys.include?("urgency")
        comment_text << 'urgency: ' + @ticket.urgency_line
      end
      if @ticket.previous_changes.keys.include?("resolution")
        comment_text << 'resolution: ' + @ticket.resolution_line
      end

      if @ticket.previous_changes.keys.include?("assigned_id")
        comment_text << '<br />Assigned to: ' + @ticket.assigned.name
        TicketMailer.send_notification(@ticket, @ticket.assigned.email).deliver_now
      end
      unless comment_text.blank?
        if params[:ticket][:comments_attributes].nil?
          @ticket.comments << Comment.create(is_system: true, user: current_user, 
          description:  'Changes were made to this ticket: ' + 
            (comment_text.blank? ? @ticket.previous_changes.to_a.flatten.join(' || ') : comment_text.join('; '))  
            )
        else
          lc = @ticket.comments.last
          lc.description += '<p><em>Changes were made to this ticket: ' + 
            (comment_text.blank? ? @ticket.previous_changes.to_a.flatten.join(' || ') : comment_text.join('; '))  + "</em></p>"
          lc.save!

        end
        
      end
      if params[:ticket][:send_email] == "1"
        TicketMailer.send_notification(@ticket).deliver_now
      end
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
      
    else
      render :edit
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.require(:ticket).permit(:tickettype_id, :project_id, :user_id, :name, :assigned_id,  :description, :urgency, :date_requested, :status, :relevant_url, :resolution,
      comments_attributes: [:id, :ticket_id, :user_id, :content, :description, :attachment, :commit_hash, :screenshot],
      screenshots_attributes: [:id, :remove_screenshot, :_destroy, :image])
    end
end
