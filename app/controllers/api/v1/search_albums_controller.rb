class API::V1::SearchAlbumsController < ApplicationController

  def index
    if params[:id]
      @album = Album.where(:id => params[:id])
    else
        @album = Album.search(params[:search]).accepted_by_label.published.release_date_desc
    end
    
    @tracks = []

    @album.each do |album|

 
        album.full_path_album_art = "http://" +request.host_with_port + album.album_art.url
     
    	  album.album_tracks.each do |t|

    		  t.music_file_file_name =  URI.join(request.url, t.music_file.url)

    	 end

    @tracks += album.album_tracks
   	
	end
	render_search_result_to_json(@tracks)


  end



end