class AlbumTracksController < ApplicationController
  layout 'standard'
  before_action :get_track_dependencies

  def new
    @track = AlbumTrack.new
  end

  def create
    @track = @album.album_tracks.new(track_params)
    @track.album_id = @album.id
    if @track.save
      message("you succesfully created a a new track")
      redirect_to([@artist,@group,@album,@track])
    else
      render('new')
    end
  end

  def index
    @tracks = @album.tracks
  end

  def show
    @track = AlbumTrack.find(params[:id])
  end

  def edit
    @track = AlbumTrack.find(params[:id])

  end

  def update
    @track = AlbumTrack.find(params[:id])
    @track.album_id = @album.id
    if @track.update_attributes(track_params)
      message("you succesfully updated a a track")
      redirect_to([@artist,@group,@album,@track])
    else
      render('edit')
    end

  end

  def delete
    @track = AlbumTrack.find(params[:id])
  end

  def destroy
    @track = AlbumTrack.find(params[:id])

    @track.music_file = nil
    @track.destroy
    redirect_to([@artist,@group,@album])
  end
  private 

  def get_track_dependencies
    @artist = Artist.find(params[:artist_id])
    @group = MusicGroup.find(params[:music_group_id])
    @album = Album.find(params[:album_id])
  end
  def track_params
    params.require(:album_track).permit(:name,:position,:music_file,:album_id)
  end
end
