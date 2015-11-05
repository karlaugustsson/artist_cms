class MusicCompaniesController < ApplicationController
  layout 'standard'
  before_action :redirect_if_not_logged_in_music_company , :except => [:create,:new]
  before_action :remove_logged_in_artist
  before_action :set_logged_in_music_company
  before_action :redirect_if_not_activated_music_company
  before_action :have_the_power, :only => :index
  before_action :auth_owner_music_company_account_or_deny_action , :only => [:edit,:update]

  def new
    @company = MusicCompany.new
  end

  def create
    @company = MusicCompany.new(music_company_params)
    if @company.save
      message("succesfully created a new musiccompany account","success")
    redirect_to(@company)
    else
      render('new')
    end

  end

  def index
    @companies = MusicCompany.all

  
  end

  def show
    @company= MusicCompany.find(params[:id])
    @labels = @company.labels
  end

  def edit
    @company = MusicCompany.find(params[:id])
  end

  def update
    @company = MusicCompany.find(params[:id])

    if @company.update_attributes(music_company_params)
      
      respond_to do |format|

        format.html {[redirect_to(@company), message("updated info", "succes")]} 

        format.js {@company} 
      end
      
    else
      render("edit")
    end
  end



  def delete
    @company = MusicCompany.find(params[:id])
  end

  def destroy
  @company= MusicCompany.find(params[:id]).destroy
  message("succesfully deleted this musiccompany account","success")
  if @onlineMusicCompany.id == @company.id
    session[:music_company] = nil
    message("you are no longer aprt of this","success")
    redirect_to("/")
  else
    redirect_to(music_companies_path)
  end
  
  end

  def grant_publish_permission
    @company = MusicCompany.find(params[:company_id])
    @album = Album.find(params[:album_id])
    
    @label = Label.find(params[:label_id])

    @album_label =  AlbumLabelRelation.where(:label_id => @label.id , :album_id => @album.id).first
     @album_label.allowed_publish = true
     @album_label.save()

    check_with_all_labels_for_publish_permission(@album,@album.labels)
    redirect_to(music_company_label_albums_path(@company,@label,@label))


  end

    def revoke_publish_permission
    @company = MusicCompany.find(params[:company_id])
    @album = Album.find(params[:album_id])
    
    @label = Label.find(params[:label_id])

      @album_label =  AlbumLabelRelation.where(:label_id => @label.id , :album_id => @album.id).first
     @album_label.allowed_publish = false
     @album_label.save()

    check_with_all_labels_for_publish_permission(@album,@album.labels)
    redirect_to(music_company_label_albums_path(@company,@label,@label))


  end

  def settings 
    @company = @onlineMusicCompany
  end


  private


  def music_company_params
    params.require(:music_company).permit(:email,:password , @onlineMusicCompany.super_power ? [:activated , :super_power]  : "")
  end

def auth_owner_music_company_account_or_deny_action

    if @onlineMusicCompany.super_power == 0 
      puts request.request_method_symbol
      
      if @onlineMusicCompany.id.to_s != params[:id]
        deny_user_action(@onlineMusicCompany)

      end

    end  
end

end
