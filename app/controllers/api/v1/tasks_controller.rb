class Api::V1::TasksController < BaseController

  before_action :find_project, only: [:index, :create]
  before_action :find_task, only: [:update, :destroy]

  def index
    @tasks = @project.tasks.all
    render :index, status: :ok
  end

  def create
    @task = @project.tasks.create(task_params)
    if @task.persisted?
      render :create, status: :created
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    task_updated = @task.update(task_params)
    if task_updated
      render :update, status: :ok
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :forecast, :done)
  end

end