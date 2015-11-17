class API::V1::SearchAlbumsController < ApplicationController

  def index
    if params[:id]
      @album = Album.where(:id => params[:id])
    elsif params[:latest_release]
      
      @album = Album.all().accepted_by_label.published.release_date_asc.limit(5)
      @album.each do |album|
        
        album.full_path_album_art = "http://" +request.host_with_port + album.album_art.url
      
      end
    
      return render :json => @album ,  :methods => [:full_path_album_art] 
    
    else
        @album = Album.search(params[:search]).accepted_by_label.published.release_date_desc
    end

    @tracks = []

    @album.each do |album|

 
        album.full_path_album_art = "http://" +request.host_with_port + album.album_art.url
     
    	  album.album_tracks.each do |t|
          t.oggpath = "http://" + request.host_with_port + t.music_file.url(:ogg)
    		  t.music_file_file_name =  URI.join(request.url, t.music_file.url)

    	 end

    @tracks += album.album_tracks
   	
	end
	render_search_result_to_json(@tracks)


  end



end