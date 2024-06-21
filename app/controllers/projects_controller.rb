class ProjectsController < ApplicationController
  before_action :set_project, only: :show
  def new

  end

  def create
    binding.pry
  end

  def edit

  end

  def update

  end

  def show

  end

  def destroy

  end
  
  private 
  
  def set_project
    @project = Project.find_by(id: params[:id])
    redirect_to root_path, notice: I18n.t('notice.not_found') if @project.blank?
  end
end
