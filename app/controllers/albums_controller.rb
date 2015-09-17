class AlbumsController < ApplicationController
      layout  'standard'
    before_action :get_current_artist_and_group
    before_action :get_music_company_labels_or_deny_action , :only =>[:create,:new,:update,:edit]
  def new
    @album = Album.new
    @label_ids = Label.all

  end

  def create
    @album = Album.new(album_params)
    if @album.save

      message('You succesfully created a new album')
      redirect_to([@artist,@group,@album])
  else
    @label_ids = Label.all
    render('new')
    end
  end

  def index
    @album = @group.albums
    @tracks = @album.album_tracks
  end

  def show
    @album= Album.find(params[:id])
  end

  def edit
    @label_ids = Label.all
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
    params.require(:album).permit(:name,:release_date,:album_art,:published,:collaborating_artists,{:label_ids => []})
  end
  def get_music_company_labels_or_deny_action
    @labels = Label.all
    @album = @group.albums
    if !@labels.empty?

    else
      message("no lables was found action cannot be performed")
      redirect_to([@artist,@group])

    end
  
  end





end
