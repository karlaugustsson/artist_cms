class API::V1::SearchAlbumTracksController < ApplicationController

  def index
    @tracks = AlbumTrack.search(params[:search])
    @filtered_tracks = []
    @tracks.each do |track|
    	if track.album.accepted_by_label == true && track.album.published == true
    	
    		track.album.full_path_album_art = "http://" + request.host_with_port + track.album.album_art.url
        track.oggpath = "http://" + request.host_with_port + track.music_file.url(:ogg)
   			track.music_file_file_name = URI.join(request.url, track.music_file.url)
        

        @filtered_tracks.push(track)


   		end

	end
	render_search_result_to_json(@filtered_tracks)

  end



end