class LoginArtistController < ApplicationController
      before_action :redirect_if_logged_in_artist , :only => [:login]
	layout 'standard'

	def login
	end
  def logout
    session[:artist] = nil
    redirect_to("/")
  end
	def attempt_login
	if params[:email].present? && params[:password].present?

  		found_user = Artist.where("email" => params[:email]).first

  	if found_user
      puts found_user.email
  		auth_user = found_user.authenticate(params[:password])
  	end	

  	if auth_user
       if auth_user.activated
           create_artist_session(auth_user.id)
      			
      		
      	redirect_to(found_user)
        else
        	message("This user has not been activated or has been deactivated","danger")
            render("login")         
        end  
  	else
  		message("wrong credentials","danger")
  		render("login")
  	end


  	else

  	message("both field are required","danger")

  	render("login")

 	end

	end


private


end
