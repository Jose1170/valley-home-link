class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!

  allow_browser versions: :modern
  
  # Define the methods first so they are available
  helper_method :current_user 

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Add the exclamation mark alias so authenticate_user! works
  def authenticate_user!
    unless current_user
     redirect_to login_path, alert: "Please log in to continue."
    end
  end

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end