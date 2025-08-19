class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  # Pundit: white-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_authorized, unless: -> { action_name == 'index' || skip_pundit? }


  def configure_permitted_parameters
    # For additional fields in Devise forms
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :photo])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
