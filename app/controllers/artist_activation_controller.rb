class ArtistActivationController < ApplicationController
before_action :have_code
	def register
	@artist = @code.artist

  	if @artist.update_columns(:activated => true)
  		message("Welcome to artist_cms","success")
  		create_artist_session(@artist.id)
  		@code.destroy()
  		redirect_to("/")
  	else
  		message("something went wrong on activation try again i suppose","alert")
  		redirect_to("/")
  	end
			
	end

  def unregister
  @artist = @code.artist
  @artist.destroy
  @code.destroy
  session[:artist] = nil
  message('You succesfully deleted your account',"succes")
  redirect_to("/")
      
  end

  private 
  def have_code
  	if !params[:code]
  		message("you have to have the code to take this action","danger")
  		redirect_to("/")
  	else
  	@code = ArtistActivationCode.where(:code => params[:code]).first

	  	if !@code
	  		message("Code is invalid","danger")
	  		redirect_to("/")
	  	end
  	return true
  end
  end
end
