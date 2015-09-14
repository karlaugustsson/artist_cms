class LabelsController < ApplicationController
  layout 'standard'
  before_action :def_music_comapny
  def new
    @label = Label.new
  end

  def create
    @label= Label.new(label_params)
    
    if @label.save
      message("you succesfully created a lebel")
      redirect_to(@company,@label)
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
    redirect_to(@company,@label)
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
    redirect_to(labels_path)
  end

  private
  
  def label_params
  params.require(:label).permit(:name)
  end
def music_comapny
  @company = MusicCompany.find(params[:id]).
end

end
