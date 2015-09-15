class LabelsController < ApplicationController
  layout 'standard'
  before_action :music_company
  def new
    @label = Label.new
  end

  def create
    @label= Label.new(label_params)
    
    if @label.save
      message("you succesfully created a lebel")
      redirect_to([@company,@label])
    else
      render('new')
    end

  end

  def index
    @labels = Label.all
  end

  def show
    @label = Label.find(params[:id])
  end

  def edit
    @label = Label.find(params[:id])
  
  end

  def update
    @label = Label.find(params[:id])

    if @label.update_attributes(label_params)
      message("you succesfully updated a lebel")
    redirect_to([@company,@label])
    else
    render('edit')
    end

  end

  def delete
    @label = Label.find(params[:id])
  end

  def destroy
    @label = Label.find(params[:id]).destroy
    message("you succesfully deleted a label")
    redirect_to(music_company_labels_path(@company))
  end

  private
  
  def label_params
  params.require(:label).permit(:label_name)
  end
def music_company
  @company = MusicCompany.find(params[:music_company_id])
end

end
