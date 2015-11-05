class LabelsController < ApplicationController
  layout 'standard'
  before_action :set_logged_in_music_company
  before_action :set_music_company_from_param
  before_action :redirect_if_not_logged_in_music_company
  before_action :auth_owner_of_resource_or_deny_changes , :only => [:edit, :update , :delete , :destroy]
  before_action :auth_label_owner_or_deny_action, :only => [:edit, :update , :delete , :destroy]
  before_action :deny_acces_to_own_label_page_if_admin , :only => [:show,:index]
  before_action :deny_creation_of_labels_for_admin , :only => [ :new,:create]

  def new
    @label = Label.new()

  end

  def create
    @label= MusicCompany.find(params[:music_company_id]).labels.new(label_params)
    
    if @label.save
      message("you succesfully created a label #{@label.label_name}" ,"success")
      redirect_to([@company,@label])
    else
      render('new')
    end

  end

  def index
    @labels = @company.labels
  end

  def show
    @label = @company.labels.find(params[:id])
  end

  def edit
    @label = Label.find(params[:id])
  
  end

  def update
    @label = Label.find(params[:id])

    if @label.update_attributes(label_params)
      message("you succesfully updated a label","success")
    redirect_to([@company,@label])
    else
    render('edit')
    end

  end

  def delete
    @label = Label.find(params[:id])
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy

    message("you succesfully deleted a label","success")
    redirect_to(music_company_labels_path(@company))
  end

  private
  
  def label_params
  params.require(:label).permit(:label_name,:music_company_id)
  end
def set_music_company_from_param
  
  if @company = MusicCompany.where(:id => params[:music_company_id]).exists?
    @company = MusicCompany.where(:id => params[:music_company_id]).first
  else
    message("couldnt find this music company","warning")
    redirect_to(@onlineMusicCompany)
  end

end


def auth_label_owner_or_deny_action

  @test = @onlineMusicCompany.labels.where(:id => params[:id]).first

    if @test != nil
     
     if @test.id.to_s != params[:id].to_s
        
          deny_user_action(@onlineMusicCompany)

      end

    else

      deny_user_action(@onlineMusicCompany)
    
    end

 end 

 def deny_creation_of_labels_for_admin
  if @company.super_power == 1 || @company.id != @onlineMusicCompany.id
    message("admin users can not have labels","warning")
    redirect_to(@onlineMusicCompany)
  end
 end

 def deny_acces_to_own_label_page_if_admin

  if params[:music_company_id].to_s == @onlineMusicCompany.id.to_s && @onlineMusicCompany.super_power == 1
    message("admin users can not have labels","warning")
    redirect_to(@onlineMusicCompany)
 end
end

end
