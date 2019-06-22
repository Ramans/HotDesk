class User < ApplicationRecord

	validates :name, presence: {:message => "#{I18n.t('validation.name')}"}, :on => :create
	
	validates :password, presence: {:message => "#{I18n.t('validation.password')}"}, :confirmation =>true, :on => :create

  	validates_confirmation_of :password, :message => "#{I18n.t('validation.passwordNotMatch')}", :on => :create

  	validates :password_confirmation, presence: {:message => "#{I18n.t('validation.passwordConfirmation')}"}, :on => :create

	validates :password, :length => { :minimum => 6, :message => "#{I18n.t('validation.passwordMinimum')}" }, :on => :create

	validates :email, presence: {:message => "#{I18n.t('validation.email')}"}, :on => :create

	validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i, :message => "#{I18n.t('validation.emailValid')}", :on => :create

	validates_uniqueness_of :email, :message => "#{I18n.t('validation.emailIdTaken')}", :on => :create


	validates_uniqueness_of :desk, :message => "#{I18n.t('validation.deskTaken')}", :on => :update

	validate :to_valid

	before_create :encrypted_password

	private

	def encrypted_password
		self.password = Digest::MD5.hexdigest(self.password)
	end

	def to_valid
		return if self.from.blank? || self.to.blank?
		begin
			if self.from > self.to
				errors.add(:to, "#{I18n.t('validation.toValidate')}") 
			end
		rescue Exception => e
			errors.add(:to, "#{I18n.t('validation.inValidDate')}")
		end
	end

end
