class User < ApplicationRecord

	validates :name, presence: {:message => "Name is required"}, :on => :create
	validates :password, presence: {:message => "Password is required"}, :confirmation =>true, :on => :create

  	validates_confirmation_of :password, :message => "Password doesn't match", :on => :create

  	validates :password_confirmation, presence: {:message => "Password confirmation is required"}, :on => :create

	validates :password, :length => { :minimum => 6, :message => 'Password should be minimum 6 characters' }, :on => :create

	validates :email, presence: {:message => "User email is required"}, :on => :create

	validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i, :message => 'Enter a valid email address', :on => :create

	validates_uniqueness_of :email, :message => "User email already taken", :on => :create


	validates_uniqueness_of :desk, :message => "Desk already taken", :on => :update

	validate :to_from_after

	before_create :encrypted_password

	private

	def encrypted_password
		self.password = Digest::MD5.hexdigest(self.password)
	end

	def to_from_after
		return if self.from.blank? || self.to.blank?
		begin
			if self.from > self.to
				errors.add(:to, "Must be after the from date") 
			end
		rescue Exception => e
			errors.add(:to, "Invalid date format")
		end
	end

end
