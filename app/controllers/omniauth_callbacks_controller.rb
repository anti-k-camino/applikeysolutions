class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :auth

  def facebook     
  end

  private
  def auth
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: action_name.capitalize) if is_navigational_format?
    end
  end  
end