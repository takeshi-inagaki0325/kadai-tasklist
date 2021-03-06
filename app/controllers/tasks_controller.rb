class TasksController < ApplicationController
  before_action :require_user_logged_in
#before_action :correct_user, only: [:destroy  ]
#  before_action :correct_user, only: [:destroy ,:update, :edit ]
  before_action :correct_user, only: [:destroy ,:update, :edit ,:show]


  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page])
  end

  def show
#    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
#    @task = current_user.Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Taskは正常に登録されました'
      redirect_to @task
    else
      flash.now[:denger] = 'Taskが登録されませんでした'
      render :new
    end
  end

  def edit
#    @task = Task.find(params[:id])
  end

  def update
    @task=Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskは登録されませんでした'
      render :edit
    end
    
  end

  def destroy
#    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to root_path
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end


end
