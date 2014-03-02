class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params, if: :devise_controller?

    def update_sanitized_params
       devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name,:last_name, :email,   :password, :password_confirmation)}
    end

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :location, :roles => [])
    end

  private :resource_params
end