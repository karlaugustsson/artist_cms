class API::V1::SearchMusicGroupsController < ApplicationController

  def index

    if params[:id]

      @group = MusicGroup.where(:id => params[:id])
  
    else
    
      @group = MusicGroup.search(params[:search])
    
    end


    @tracks = []

    @group.each do |group|
     
      group.albums.accepted_by_label.published.release_date_desc.each do |album|


        
          album.full_path_album_art = "http://" + request.host_with_port + album.album_art.url

          
          album.album_tracks.each do |track|

          
            track.music_file_file_name = URI.join(request.url, track.music_file.url)
            
            @tracks.push(track)
          
    
          end

    end
end
  puts @tracks.as_json
	render_search_result_to_json(@tracks)



end



end