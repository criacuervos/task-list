class TasksController < ApplicationController

  def index
    @tasks = Task.all  
  end 

  def show
    task_id = params[:id].to_i

    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_Found
      return
    end 
  end 

  def new
    @task = Task.new
  end 

  def create
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date] )
    
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
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completion_date = params[:task][:completion_date]

    if @task.save
      redirect_to task_path(@task.id)
    else 
      render new_task_path
    end 
  end 

end
