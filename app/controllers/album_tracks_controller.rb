class AlbumTracksController < ApplicationController
  layout 'standard'
  before_action :get_track_dependencies
  before_action :set_logged_in_artist 
  before_action :redirect_if_not_logged_in_artist
  before_action :auth_owner_of_resource_or_deny_changes , :only => [:new,:create,:edit,:update, :delete , :destroy]
  before_action :auth_owner_of_track_or_deny_changes , :only => [:edit,:update, :delete , :destroy]

  def new
    
    @track_length = Album.find(@album).album_tracks.count + 1
    @track = AlbumTrack.new(:position => @track_length)
  end

  def create
    @track = @album.album_tracks.new(track_params)
    @track.album_id = @album.id
    if @track.save
      message("you succesfully created a a new track","succes")
      redirect_to([@artist,@group,@album,@track])
    else
      @track_length = Album.find(@album).album_tracks.count + 1
      render('new')
    end
  end

  def index
    @tracks = @album.album_tracks
  end

  def show
    @track = @group.albums.find(@album.id).album_tracks.find(params[:id])
 
  end

  def edit
    @track = AlbumTrack.find(params[:id])
    @track_length = Album.find(@album.id).album_tracks.count

  end

  def update
    @track = AlbumTrack.find(params[:id])
    @track.album_id = @album.id
    if @track.update_attributes(track_params)
      message("you succesfully updated a a track","succes")
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

  def auth_owner_of_track_or_deny_changes
    @thistrack = @onlineArtist.music_groups.where(:id => params[:music_group_id]).first.albums.where(:id => params[:album_id]).first.album_tracks.where(:id => params[:id]).first
    if @thistrack == nil
      deny_user_action(@onlineArtist)

    end
end
end
