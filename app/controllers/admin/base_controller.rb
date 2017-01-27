class Admin::BaseController < ApplicationController
  # layout 'admin'

  before_action :authenticate_user!
  # before_action :authenticate_admin!
  #load_and_authorize_resource #except: [:home, :proposal, :resubmit, :respend, :retransfer], find_by: :slug
  
  def authenticate_admin!
    redirect_to root_path unless current_user.has_role? :admin
  end
  
  def check_permissions
    authorize! :create, resource
  end


end
  