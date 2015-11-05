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

	   		unless session[:artist] || session[:music_company]

	   			message("you need to be logged in to view this page","danger")
	   			redirect_to("/")
	   		end	
	   		return true
	   			
	end

		def redirect_if_logged_in_artist
	   		if session[:artist]
	   			redirect_to(artist_path(session[:artist]))
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


	def set_logged_in_music_company
	if MusicCompany.where(:id => session[:music_company]).first != nil
		@onlineMusicCompany = MusicCompany.where(:id => session[:music_company]).first
	else
		remove_logged_in_music_company
		redirect_to("/")
	end
	end

	def remove_logged_in_music_company
	@onlineMusicCompany = nil
	session[:music_company] = nil
	end

	def set_logged_in_artist
	
	if session[:artist]
		@onlineArtist = Artist.where(:id => session[:artist]).first
		
	end
		


	if session[:music_company]
		@onlineMusicCompany = MusicCompany.find(session[:music_company])
	end 


	if @onlineArtist || @onlineMusicCompany
		return true
	else
		message("unable to find your account try login in again", "danger")
		redirect_to("/")
	end
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
		session[:artist] = nil
		@onlineArtist = nil
	  session[:music_company] = id
end

def create_artist_session(id)

	  session[:artist] = id
end
def redirect_if_not_activated_music_company
	if @onlineMusicCompany.activated == 0
		session[:music_company] = nil
		@onlineMusicCompany = nil

		message("your account has not been activated and can therefor no be used" , "warning")
		redirect_to(music_companies_login_path)
	end
end

  def check_with_all_labels_for_publish_permission album ,labels
  	
    @counter = 0
    labels.each do |l|
    	puts l.id
      @album_label = AlbumLabelRelation.where(:label_id => l.id , :album_id => album.id).first
      
      if @album_label.allowed_publish == 0 || @album_label.allowed_publish == nil
          
        @counter = @counter + 1
      
      end

    end

    if @counter == 0
      album.accepted_by_label = true

    
    else

     album.accepted_by_label = false 
    
    end

    album.save()
  end

def render_search_result_to_json(tracks)

 render :json => tracks ,:only => [:position,:name ,:track_length, :music_file_file_name, :music_file_content_type , :id], :include =>
 		{:album =>
 			{:only => [:id,:name,:release_date],:include =>
 		 		{:labels => {},:music_groups =>
 		 			{:only => [:id,:name]

 		 			}
 		 		}, :methods => [:full_path_album_art]
 		 	}
 		}

end


    def auth_owner_of_resource_or_deny_changes

      if params[:artist_id]
      	if authenticate_resource([params[:artist_id]],"artist") == true
      		if params[:music_group_id]
        		if authenticate_resource([params[:music_group_id]],"music group") == true
        			if params[:album_id]
        
        				authenticate_resource([params[:music_group_id],params[:album_id]],"album")
  					end
        		end
     		end 
      	end
      end
      

      if params[:music_company_id]
      	if authenticate_resource([params[:music_company_id]],"company") == true
      		if params[:label_id]
      			authenticate_resource([params[:music_company_id],params[:label_id]],"label")
      		end
		end
 	 end
end


  def authenticate_resource value , name
  	case name
  	when "artist"
  		@test = Artist.where(:id => value[0]).first
  		@subject = @onlineArtist
  	when "music group"
  		@test = MusicGroup.where(:id => value[0]).first
  		@@subject = @onlineArtist.music_groups.where(:id => value[0]).first
  	when "album"
  		@test = Album.where(:id => value[1]).first
  		@subject= @onlineArtist.music_groups.where(:id => value[0]).first.albums.where(:id => value[1]).first
  	when "company"
  		@test = MusicCompany.where(:id => value[0]).first
  		@subject = @onlineMusicCompany
  		if @subject.super_power == 1 
  				return
  		end 
  	when "label"
  		@test = Label.where(:id => value[0]).first
  		@subject = @onlineMusicCompany.labels.where(:id => value[1]).first  		
  	

  	end

    if @test != nil && @subject!= nil

      if @test.id.to_s == @subject.id.to_s
      	return true
      else

         deny_user_action(@subject)
      end  
      
    else

      deny_user_action(@subject)
    end
  
  end


  def  deny_user_action user
  	puts user.id
    message("you are not allowed to make changes to others account" , "warning")
    return redirect_to(user)
end

end





