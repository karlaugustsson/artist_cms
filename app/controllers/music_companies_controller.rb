class MusicCompaniesController < ApplicationController
  layout 'standard'
  def new
    @company = MusicCompany.new
  end

  def create
    @company = MusicCompany.new(music_company_params)
    if @company.save
      message("succesfully created a new musiccompany account")
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
      message("succesfully updated this musiccompany account")
      redirect_to(@company)
    else
      render("edit")
    end
  end



  def delete
    @company = MusicCompany.find(params[:id])
  end

  def destroy
  @company= MusicCompany.find(params[:id]).destroy
  message("succesfully deleted this musiccompany account")
  redirect_to(music_companies_path)
  end

  private
  def music_company_params
    params.require(:music_company).permit(:email,:password)
  end
end
