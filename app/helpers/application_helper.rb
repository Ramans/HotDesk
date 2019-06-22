module ApplicationHelper

	def require_user
        @current_user = User.find_by_id(session[:user_id])
        if @current_user.blank?
            redirect_to posts_url
        end
    end
    
end
