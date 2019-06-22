class UsersController < ApplicationController

	include ApplicationHelper

	before_action :require_user, :except => ["new", "create", "login", "logout", "admin_register"]

	before_action :find_user, :only => ["update", "destroy", "edit"]

	def new
		@user = User.new
	end

	def admin_register
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		
		if @user.save
			redirect_to login_url
		else
			if params[:user][:user_type] == "admin"
				render "admin_register"
			else
				render "new"
			end
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
					@user.errors.add(:login, "#{I18n.t('login.invalidLogin')}")
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
	end

	def update
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

	def destroy
		if @user.present?
			@user.destroy
		end
		redirect_to users_url
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :status, :user_type)
	end

	def update_params
		params.require(:user).permit(:desk, :from, :to, :status)
	end

	def find_user
		if admin?
			@user = User.find(params[:id])
		else
			if params[:id].to_i == @current_user.id
				@user = User.find(@current_user.id)
			else
				render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => true
			end
		end
	end

end
