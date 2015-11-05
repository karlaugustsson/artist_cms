class ArtistMailer < ApplicationMailer

	def register_artist_email user , code , serverurl
	@user = user
    @comfirmation_string = code
    @url  = "http://" + serverurl +"/artist_activation/register/?code=#{@comfirmation_string}"
    mail(to: @user.email, subject: 'Welcome to artist_cms')
	end

	def unregister_artist_email user , code , serverurl
	@user = user
    @comfirmation_string = code
    @url  = "http://" + serverurl +"/artist_activation/unregister/?code=#{@comfirmation_string}"
    mail(to: @user.email, subject: 'hate to see you go')
	end

	def send_message_about_unpublish user ,label
		@user = user
		@label = label

		mail(to: @user.email, subject: "#{@label.label_name} is no more , some of your albums have been unpublished")
	end
end
