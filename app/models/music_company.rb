class MusicCompany < ActiveRecord::Base
	has_many :labels , :dependent => :destroy
	has_secure_password

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i	

	validates_presence_of(:email) 


	validates_format_of(:email , :with => EMAIL_REGEX)
	validates_uniqueness_of(:email)

end
