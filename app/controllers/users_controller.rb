class UsersController < ApplicationController

	include ApplicationHelper

	before_action :require_user, :except => ["new", "create", "login", "logout"]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		
		if @user.save
			redirect_to login_url
		else
			render "new"
		end
	end

	def login
		if session[:user_id].present?
			redirect_to users_url
		else
			if request.post?
				@user = User.find_by_email(params[:email])

				if @user.present? and @user.password == Digest::MD5.hexdigest(params[:password])
					session[:user_id] = @user.id
					@current_user = @user
					redirect_to users_url
				else
					@user = User.new
					@user.errors.add(:login, "Invalid login details")
				end
			end
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(@current_user.id)
	end

	def update
		@user = User.find(@current_user.id)

		if @user.update_attributes(update_params)
			redirect_to user_url(@user)
		else
			render "edit"
		end
	end

	def cancel_seat
		@user = User.find(@current_user.id)
		@user.desk = nil
		@user.from = nil
		@user.to = nil
		@user.save
		redirect_to users_url
	end

	def logout
		reset_session
		redirect_to login_url
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def update_params
		params.require(:user).permit(:desk, :from, :to)
	end

end
