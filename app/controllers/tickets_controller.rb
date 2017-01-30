class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:landing]
  
  # GET /tickets
  def index
    if current_user.has_role? :admin
      @tickets = Ticket.all.order(created_at: :desc)
    else
      @tickets = current_user.projects.map(&:tickets).flatten.sort_by(&:created_at).reverse
    end
  end


  def landing
    
  end
  # GET /tickets/1
  def show
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
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tickets/1
  def update

    if @ticket.update(ticket_params)

      if params[:ticket][:system_call] == "1"
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

        Comment.create(ticket: @ticket, is_system: true, user: current_user, description: 'Changes were made to this ticket: ' + comment_text.join('; ')  )
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
      params.require(:ticket).permit(:tickettype_id, :project_id, :user_id, :name, :description, :urgency, :date_requested, :status, :relevant_url, :resolution,
      screenshots_attributes: [:id, :remove_screenshot, :_destroy, :image])
    end
end
