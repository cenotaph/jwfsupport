class UsersController < ApplicationController
  
  def edit
    # users can edit their own profile, somewhat
    @user = User.friendly.find(params[:id])
    if cannot? :update, @user
      flash[:error] = 'You cannot edit another user profile'
      redirect_to '/'
    end

  end
  
  def index
    @project = Project.find(params[:project_id])
    @users = @project.users.order(:name)
    render json: @users
  end
  
  def theme_switch
    
    current_user.update_attribute(:theme, params[:theme])
    redirect_to '/'
  end
  
  def update
    @user = User.friendly.find(params[:id])
    if can? :update, @user
      if @user.update_attributes(user_params)
        flash[:error] = ''
        flash[:warning] = ''
        flash[:notice] = 'Profile info saved.'
        redirect_to edit_user_path(@user)
      else
        flash[:error] = @user.errors.full_messages.join('. ')
        render template: 'users/edit'
      end
    else
      flash[:error] = 'You cannot edit another user profile'
      redirect_to '/'
    end
  end
  
  protected
  
  def user_params
    params.require(:user).permit(:email, :name, :username, :avatar)
  end
end