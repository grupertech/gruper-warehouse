class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  layout :layout_by_resource
  skip_before_action :verify_authenticity_token

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options
    { locale: I18n.locale }
  end

  private
    def layout_by_resource
      if devise_controller?
        "app-login"
      else
        "application"
      end
    end

  protected
    def after_sign_in_path_for(resource)
      admin_root_path
    end
end