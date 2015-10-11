class API::V1::SearchAlbumTracksController < ApplicationController

  def index
    @tracks = AlbumTrack.search(params[:search])
    @tracks.each do |track|
    	track.album.full_path_album_art = "http://" + request.host_with_port + track.album.album_art.url
   		track.music_file_file_name = URI.join(request.url, track.music_file.url)


	end
	render_search_result_to_json(@tracks)

  end



end