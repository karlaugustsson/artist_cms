class ArtistsController < ApplicationController
  layout "standard"
  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      message('You succesfully created an artist')
      redirect_to(@artist)
    else
      render('new')
    end
  end

  def index
  @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
  @artist = Artist.find(params[:id])
  if @artist.update_attributes(artist_params)
    message('You succesfully updated an artist')
      redirect_to(@artist)
  else
    render('edit')
  end
  end

  def delete
    @artist = Artist.find(params[:id])
  end

  def destroy
  @artist = Artist.find(params[:id]).destroy
  @artist.destroy
  message('You succesfully deleted an artist')
  redirect_to(artists_path)
  end

  private
  def artist_params
  params.require(:artist).permit(:email,:password)
  end
end
