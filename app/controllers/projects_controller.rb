class ProjectsController < ApplicationController
  
  def show
    @project = Project.friendly.find(params[:id])
    if @project.users.include?(current_user) || current_user.has_role?(:admin)
      @tickets = @project.tickets
      # @progress_total = (Ticket.closed.size.to_f / Ticket.all.size.to_f).to_f * 100
      @progress_project = (@project.tickets.closed.size.to_f / @project.tickets.size.to_f).to_f * 100
    else
      flash[:notice] = 'You do not have permission to view this project.'
      redirect_to '/'
    end
  end
  
end