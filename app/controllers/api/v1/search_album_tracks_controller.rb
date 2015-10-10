class API::V1::SearchAlbumTracksController < ApplicationController

  def index
    @tracks = AlbumTrack.search(params[:search])
    @tracks.each do |track|
   		track.music_file_file_name = "http://localhost:3000" + track.music_file.url
	end
	render_search_result_to_json(@tracks)

  end



end