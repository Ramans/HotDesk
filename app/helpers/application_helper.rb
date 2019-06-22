module ApplicationHelper

	def require_user
        @current_user = User.find_by_id(session[:user_id])
        if @current_user.blank?
            redirect_to login_url
        end
    end

    def format_date(date)
    	if date.present?
	        date.to_datetime.strftime("%d %b")
	    else
	      return ""
	    end
    end

    def admin?
        if @current_user.present? and @current_user.user_type == "admin"
            return true
        else
            return false
        end
    end
    
end
