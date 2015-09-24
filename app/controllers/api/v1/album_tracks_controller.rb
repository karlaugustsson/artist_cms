class API::V1::AlbumTracksController < ApplicationController

  def index
    @tracks = AlbumTrack.all
    @tracks.each do |track|
   	track.music_file_file_name = track.music_file.url
	end
 	render :json => @tracks

  end

    def show
    @track = AlbumTrack.find(params[:id])
 	render :json => @track

  end

end