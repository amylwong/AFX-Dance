class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def root_redirect
    redirect_to "/admin"
  end
  
  def access_denied(exception)
    redirect_to "/admin/login"
    #redirect_to admin_organizations_path, :alert => exception.message
  end
end
