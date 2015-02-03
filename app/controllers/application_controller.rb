class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize
  before_action :set_i18n_locale_from_params
  protect_from_forgery with: :exception
  #rescue_from Exception, with: :email_exception


  protected
    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def set_i18n_locale_from_params
      if(params[:locale])
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      {locale: I18n.locale}
    end

  private
  def email_exception(error)
    @error = error.message
    OrderNotifier.sys_admin_mail(@error).deliver_later
    redirect_to store_url, notice: 'Invalid_search'
  end
end
