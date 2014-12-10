class TasksController < ApplicationController
  layout 'todo'
  
  def index
    @tasks = current_user.tasks
    @task = Task.new
  end

  def create
    @task.user = current_user
    if @task.save
      redirect_to({action: 'index'}, notice: 'Task was successfully created')
    end
  end

  def show
    @task = Task.find(params[:id])
  end
  

  private

    def task_params
      params.require(:task).permit(:title, :description)
    end

end
