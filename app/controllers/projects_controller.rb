class ProjectsController < ApplicationController
  
  has_scope :closed, type: :boolean
  has_scope :opened, type: :boolean
  
  def show
    @project = Project.friendly.find(params[:id])
    @opened_count = @project.tickets.opened.size
    @closed_count = @project.tickets.closed.size
    @total_count = @project.tickets.size
    if @project.users.include?(current_user) || current_user.has_role?(:admin)
      @tickets = apply_scopes(@project.tickets)
      # @progress_total = (Ticket.closed.size.to_f / Ticket.all.size.to_f).to_f * 100
      @progress_project = (@project.tickets.closed.size.to_f / @project.tickets.size.to_f).to_f * 100
    else
      flash[:notice] = 'You do not have permission to view this project.'
      redirect_to '/'
    end
  end
  
end