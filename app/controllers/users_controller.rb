class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  respond_to :js

  def show
  end
  
  def update
    @user.update_attributes(user_params)
    respond_with @user
  end

  protected
  def set_user
    @user = current_user
  end

  def user_params    
    params.require(:user).permit(:name, :image)
  end
end
