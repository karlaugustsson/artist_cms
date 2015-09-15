class AlbumsController < ApplicationController
    before_action :get_current_artist_and_group
  def new
    @album = Album.new

  end

  def create
    @album = Album.new(album_params)

    if @album.save
      @group.albums << @album
      message('You succesfully created a new album')
      redirect_to([@artist,@group,@album])
    else
      render('new')
    end
  end

  def index
    @album = @group.albums
  end

  def show
    @album= Album.find(params[:id])
  end

  def edit
    @album= Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      message('You succesfully updated an album')
      redirect_to([@artist,@group,@album])
    else
      render('edit')
    end
  end

  def delete
    @album = Album.find(params[:id])
  end

  def destroy
      @album = Album.find(params[:id]).destroy
      @album.remove_album_art!
      @album.save
      @album.destroy

      message('You succesfully deleted an album')
      redirect_to([@artist,@group,@album])
  end

  private
  def get_current_artist_and_group
    @artist = Artist.find(params[:artist_id])
    @group = MusicGroup.find(params[:music_group_id])
  end
  def album_params
    params.require(:album).permit(:name,:release_date,:album_art,:published,:collaborating_artists)
  end
end