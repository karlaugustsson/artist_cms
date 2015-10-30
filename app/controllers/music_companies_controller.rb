class MusicCompaniesController < ApplicationController
  layout 'standard'
  before_action :redirect_if_not_logged_in_music_company , :except => [:create,:new]
  before_action :set_logged_in_music_company
   before_action :remove_logged_in_artist
  before_action :have_the_power, :only => :index
  before_action :redirect_if_not_activated
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

  private
  def music_company_params
    params.require(:music_company).permit(:email,:password , @onlineMusicCompany.super_power ? [:activated , :super_power]  : "")
  end
end
