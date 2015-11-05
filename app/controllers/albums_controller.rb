class AlbumsController < ApplicationController
      layout  'standard'
    before_action :redirect_if_not_logged_in_artist
    before_action :set_logged_in_artist
    before_action :auth_owner_of_resource_or_deny_changes , :only => [:edit,:update, :delete , :destroy ,:create,:new]
    before_action :auth_owner_of_album_or_deny_changes , :only => [:edit,:update, :delete , :destroy]
    before_action :get_current_owners
    before_action :get_music_company_labels_or_deny_action , :only =>[:create,:new,:update,:edit]
    
  def new
    @album =  Album.new
    @label_ids = Label.all

  end

  def create
    @album = Album.new(album_params)
    if @album.save
      @album.music_groups << @owner
      message("You succesfully created a new album","success")
      redirect_to([@artist,@owner,@album])
  else
    @labels = Label.all
    render('new')
    end
  end

  def index
    @album = @owner.albums


  end

  def show
    @album= @owner.albums.find(params[:id])
    @tracks = @album.album_tracks.position_asc
  end

  def edit
    @label_ids = Label.all
    @album= @owner.albums.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      check_with_all_labels_for_publish_permission(@album,@album.labels)
      message('You succesfully updated an album',"success")
      redirect_to([@artist,@owner,@album])
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
      @album.album_label_relation.delete()
      @album.save
      @album.destroy

      message('You succesfully deleted an album',"succes")
      redirect_to([@artist,@owner,@album])
  end

  private
  
  def get_current_owners
    if params[:artist_id] && params[:music_group_id]
      @artist = Artist.find(params[:artist_id])
      @owner = @artist.music_groups.find(params[:music_group_id])
    else
    @company = MusicCompany.find(params[:music_company_id])
    @owner = @company.labels.find(params[:label_id])

    end

  end


  def album_params
    params.require(:album).permit(:name,:release_date,:album_art,:album_art_cache,:published,:music_group_id => [],:label_ids => [])
  end



  def get_music_company_labels_or_deny_action
    @labels = Label.all
    @album = @owner.albums
    if !@labels.empty?

    else
      message("no lables was found action cannot be performed","danger")
      redirect_to([@artist,@group])

    end
  
  end
  
def auth_owner_of_album_or_deny_changes
    @thisAlbum = @onlineArtist.music_groups.where(:id => params[:music_group_id]).first.albums.where(:id => params[:id]).first
    if @thisAlbum == nil
      deny_user_action(@onlineArtist)

    end
end

end
