class ApplicationController < ActionController::Base

	before_action :set_locale

	def set_locale
        $host = request.host

        if params[:locale].present?
            session[:locale] = params[:locale]
            locale = session[:locale]
        else
            locale = "en"
        end

        I18n.locale = locale || I18n.default_locale

        if params[:locale].blank?
            params[:locale] = locale
        end
    end

    def current_user
        @current_user = User.find_by_uuid(session[:user_id]) if session[:user_id]
    end

    def default_url_options(options={})
        { :locale => I18n.locale }
    end

end
