class ProjectsController < ApplicationController
  
  def show
    @project = Project.friendly.find(params[:id])
    if @project.users.include?(current_user) || current_user.has_role?(:admin)
      @tickets = @project.tickets
    else
      flash[:notice] = 'You do not have permission to view this project.'
      redirect_to '/'
    end
  end
  
end