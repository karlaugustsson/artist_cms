class API::V1::MusicGroupsController < ApplicationController

  def index
  	if params[:search]
  	@group = MusicGroup.search(params[:search])
  	else
  	@group = MusicGroup.all
  	end
    
 	render :json => @group 

  end

    def show
    @group = MusicGroup.find(params[:id])
 	render :json => @group 

  end

end