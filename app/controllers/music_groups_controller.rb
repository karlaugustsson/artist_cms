class MusicGroupsController < ApplicationController
  layout 'standard'
  before_action :get_current_artist
  def new
    @group = MusicGroup.new
  end

  def create
    @group = @artist.music_groups.new(group_params)
    if @group.save
      @artist.music_groups << @group
      message('You succesfully created a musicact',"success")
      redirect_to([@artist,@group])
    else
      render('new')
    end
  end

  def index
    @group = @artist.music_groups.all

  end

  def show
    @group = @artist.music_groups.find(params[:id])
  end

  def edit
    @group = MusicGroup.find(params[:id])
  end

  def update
      @group = MusicGroup.find(params[:id])
  if @group.update_attributes(group_params)
      message('You succesfully updated a musicact',"success")
      redirect_to(artist_music_group_path(@artist,@group))
  else
    render('edit')
  end
  end

  def delete
    @group = MusicGroup.find(params[:id])
  end

  def destroy
  @group = MusicGroup.find(params[:id]).destroy
  
  @group.destroy
  message('You succesfully deleted a musicact',"success")
  redirect_to(artist_music_groups_path(@artist))
  end

  private

  def get_current_artist
    @artist = Artist.find(params[:artist_id])
  end

  def group_params
    params.require(:music_group).permit(:name,:solo_work,:formation_date,:tag_name,:artist_id,:album_id)
  end
end
