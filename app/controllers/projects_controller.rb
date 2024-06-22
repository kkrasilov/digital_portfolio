class ProjectsController < ApplicationController
  before_action :set_project, only: :show
  before_action :set_user_project, only: %i[edit update destroy]
  def new; end

  def create
    @project = Project.new(project_params)

    if @project.save
      ProjectUser.create(user: current_user, project: @project)
      flash[:notice] = I18n.t('notice.updated')
      redirect_to portfolio_path(current_user.portfolio)
    else
      flash[:error] = @project.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = I18n.t('notice.updated')
    else
      flash[:error] = @project.errors.full_messages
    end

    redirect_to project_path(@project)
  end

  def show; end

  def destroy
    @project.destroy
    flash[:notice] = I18n.t('notice.delete_project')
    redirect_to portfolio_path(current_user.portfolio)
  end
  
  private

  def project_params
    params.require(:project).permit(:title, :status, :image, :progress, :content, :base_url, :code_url, 
                                    :technologies, :short_description)
  end
  
  def set_project
    @project = Project.find_by(id: params[:id])
    redirect_to root_path, notice: I18n.t('notice.not_found') if @project.blank?
  end

  def set_user_project
    @project = current_user&.projects&.find_by(id: params[:id])
    redirect_to root_path, notice: I18n.t('notice.not_found') if @project.blank?
  end
end
