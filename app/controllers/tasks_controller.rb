class TasksController < ApplicationController
  layout 'todo'
  DAYS_COUNT = 4

  def index
    @start_date = Date.today.in_time_zone
    @days_count = DAYS_COUNT
    @tasks = get_tasks_in_date_range @start_date
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      redirect_to({action: 'index'}, notice: 'Task was successfully created')
    end

  end

  def show
    @task = Task.find(params[:id])
  end
  
  def update
    @task = current_user.tasks.find params[:id]
    respond_to do |format|
    if @task.update_attributes(task_params)
      format.html { redirect_to({action: 'index'}, :notice => 'Task was successfully updated.') }
      format.json { respond_with_bip(@task) }
    else
      format.html { render :action => "edit" }
      format.json { respond_with_bip(@task) }
    end
  end


  end

  def get_tasks_in_date_range start_date, days_count = DAYS_COUNT
    end_date = start_date + (days_count).days
    tasks = current_user.tasks.where("due_date >= ? AND due_date < ?", start_date, end_date)
    tasks_by_date = {}
    tasks.each do |task|
      current_day = (task.due_date.to_date - @start_date.to_date).to_i
      tasks_by_date[current_day.to_s.to_sym] = [] if tasks_by_date[current_day.to_s.to_sym].nil?
      tasks_by_date[current_day.to_s.to_sym] << task
    end
    tasks_by_date
  end

  private

    def task_params
      task_params = params.require(:task).permit(:title, :description, :status, :due_date, :time_required, :time_taken)
        if task_params.include? "due_date"
          task_params["due_date"] = Date.parse(task_params["due_date"]).to_time
        end
      return task_params
    end
end
