class ProjectsController < ApplicationController
  
  def show
    @project = Project.friendly.find(params[:id])
    @tickets = @project.tickets
  end
  
end