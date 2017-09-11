class Api::V1::ProjectsController < BaseController

  before_action :find_project, only: [:update, :destroy]

  def index
    @projects = Project.order(created_at: :desc)
    render :index, status: :ok
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.persisted?
      render :create, status: :created
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    project_updated = @project.update(project_params)
    if project_updated
      render :update, status: :ok
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def find_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end