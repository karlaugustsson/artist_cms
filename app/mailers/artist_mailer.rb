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
end
