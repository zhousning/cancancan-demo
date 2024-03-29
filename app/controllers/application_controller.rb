class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :email, :password, roles: [])}
      devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:name, :role)}
    end

    def self.permission
      return name = controller_name.classify.constantize
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end
       
    #load the permissions for the current user so that UI can be manipulated
    def load_permissions
      @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
    end
end
