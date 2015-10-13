class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


      def message message
      flash['notice'] = message
    end 
    def render_search_result_to_json(tracks)

 	render :json => tracks ,:only => [:name ,:track_length, :music_file_file_name, :music_file_content_type], :include =>
 		{:album =>
 			{:only => [:id,:name],:include =>
 		 		{:music_groups =>
 		 			{:only => [:id,:name]

 		 			}
 		 		}, :methods => [:full_path_album_art]
 		 	}
 		}

    end
end
