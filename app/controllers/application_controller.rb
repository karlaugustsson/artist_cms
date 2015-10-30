class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def message message  , type
	    flash['notice'] = message
	    flash['type'] = type
	end


	def redirect_if_not_logged_in_music_company
	   		unless session[:music_company]

	   			message("you need to be logged in to view this page","danger")
	   			redirect_to("/")
	   		end	
	   			
	end

	def redirect_if_not_logged_in_artist
	   		unless session[:artist]

	   			message("you need to be logged in to view this page","danger")
	   			redirect_to("/")
	   		end	
	   			
	end

	def have_the_power
		if @onlineMusicCompany.super_power == 1
			return true
		else
			message("only people with the power may access this page" , "danger")
			redirect_to(@onlineMusicCompany)
		end
	end
	def redirect_if_logged_in_artist
	   		if session[:artist]
	   			redirect_to(artist_path(session[:artist]))
	   		end	
	   			
	end

	def set_logged_in_music_company
	@onlineMusicCompany = MusicCompany.find(session[:music_company])
	end

	def remove_logged_in_music_company
	@onlineMusicCompany = nil
	session[:music_company] = nil
	end

	def set_logged_in_artist
	@onlineArtist = Artist.find(session[:artist])
	end
	
	def remove_logged_in_artist
	@onlineArtist = nil
	session[:artist] = nil
	end

	def generate_random_string

	  o = [('a'..'z'), ('A'..'Z'), (1 .. 9)].map { |i| i.to_a }.flatten
	    
	  return (0...50).map { o[rand(o.length)] }.join 

	end 

	def create_music_company_session(id)
	  session[:music_company] = id
	end

	def create_artist_session(id)
	  session[:artist] = id
	end

    def render_search_result_to_json(tracks)

 	render :json => tracks ,:only => [:position,:name ,:track_length, :music_file_file_name, :music_file_content_type], :include =>
 		{:album =>
 			{:only => [:id,:name,:release_date],:include =>
 		 		{:labels => {},:music_groups =>
 		 			{:only => [:id,:name]

 		 			}
 		 		}, :methods => [:full_path_album_art]
 		 	}
 		}

    end

end



