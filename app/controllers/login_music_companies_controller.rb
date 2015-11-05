class LoginMusicCompaniesController < ApplicationController
	layout 'standard'

	def login
	end
  def logout
    session[:music_group] = nil
    redirect_to("/")
  end
	def attempt_login
	if params[:email].present? && params[:password].present?

  		found_user = MusicCompany.where("email" => params[:email]).first

  	if found_user
  		auth_user = found_user.authenticate(params[:password])
  	end	

  	if auth_user
       if auth_user.activated
           create_music_company_session(auth_user.id)
      			
      		
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
end
