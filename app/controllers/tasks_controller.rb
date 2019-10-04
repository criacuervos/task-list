class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
    # Completed... if the form is there, it will come back as ""... if it's not, probably will come back as nil. Pick one! (Or both and code for both)
    @incomplete_tasks = Task.where(completed: nil)
    @completed_tasks = Task.completed 
    #Find the opposite here 
  end 
  
  
  def show
    task_id = params[:id].to_i
    
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end 
  end 
  
  def new
    @task = Task.new
  end 
  
  def create
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed] )
    
    if @task.save
      redirect_to task_path(@task.id)
    else 
      render new_task_path
    end 
  end 
  
  def edit
    @task = Task.find_by(id: params[:id])  
  end 
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      head :internal_server_error
      return
    end 
    
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completed = params[:task][:completed]
    
    if @task.save
      redirect_to task_path(@task.id)
    else 
      render new_task_path
    end 
  end 
  
  def destroy
    task_to_delete_id = params[:id].to_i
    
    if task_to_delete_id.nil?
      redirect_to tasks_path
    else
      Task.destroy(task_to_delete_id)
      redirect_to task_path 
    end
  end 
  
  def completed
    Task.where(id: params[:task_id]).update_all(completed: true)
    
    redirect_to tasks_path
  end 
  
end
