class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
    	redirect_to root_url, :alert => exception.message
  end

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:fname,:lname ,:email, :password,:image)}

        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:fname,:lname ,:acc_status,:email, :password, :current_password,:image)}
      end
end
