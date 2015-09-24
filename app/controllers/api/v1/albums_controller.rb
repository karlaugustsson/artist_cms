class API::V1::AlbumsController < ApplicationController
	before_action :get_music_group
  def index

  	@album = @group.albums


 	render :json => @album  ,:include => :labels

  end

    def show
    @album = @group.albums.find(params[:id])
 	render :json => @album

  end

  private 

  def get_music_group
  	@group = MusicGroup.find(params[:music_group_id])
  end

end