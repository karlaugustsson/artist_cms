class ArtistsController < ApplicationController
  before_action :redirect_if_not_logged_in_artist , :except => [:new,:create]
  before_action :redirect_if_logged_in_artist , :only => [:new]
  before_action :set_logged_in_artist , :except => [:new , :create]
  before_action :remove_logged_in_music_company
  before_action :auth_owner_of_artist_or_deny_action , :only => [:edit,:update,:delete,:destroy]

  layout "standard"
  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @code = ArtistActivationCode.new()
    @code.code = new_artist_activation_code()
     @code.save
     @artist.activation_code = @code
    if @artist.save
        ArtistMailer.register_artist_email(@artist,@code.code , request.host_with_port).deliver_later
      
      message('You succesfully created an artist account check email for activation',"succes")
      redirect_to("/")
    else
      render('new')
    end
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
    message('You succesfully updated an artist',"success")
      redirect_to(@artist)
  else
    render('edit')
  end
  end

  def delete
    @artist = Artist.find(params[:id])
  end

  def destroy

    @artist = Artist.find(params[:id])

    if @artist.activation_code == nil
      @code = ArtistActivationCode.new()
      @code.code = new_artist_activation_code()
      @code.artist_id = @artist.id
      @code.save
      @artist.activation_code = @code

    else
    
    @code = @artist.activation_code  
    
    end
    ArtistMailer.unregister_artist_email(@artist,@code.code , request.host_with_port).deliver_later
    message("a mail with link to remove your account has been sent","success")
    redirect_to("/", :controller => "public")
end

def settings
  @artist = @onlineArtist
end

  private
  def artist_params
  params.require(:artist).permit(:email,:password)
  end

  def new_artist_activation_code
      
    while true
        uniquestring = generate_random_string
        if ArtistActivationCode.where(:code => uniquestring).first == nil
          return uniquestring
        end
      
    end
end


def auth_owner_of_artist_or_deny_action

    if @onlineArtist.id.to_s != params[:id]
      deny_user_action(@onlineArtist)

    end
end



end
