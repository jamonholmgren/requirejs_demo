class TasksController < ApplicationController
  before_filter :find_model
  respond_to :html, :json
  
  def index
    respond_with(Task.all)
  end

  def show
    respond_with(@model)
  end

  def create
    @model = Task.create(params[:task])
    respond_with(@model)
  end

  def update
    @model.update_attributes(params[:task])
    render json: @model
  end

  def destroy
    @model.destroy
    respond_with(@model)
  end

  private
  def find_model
    @model = Task.find(params[:id]) if params[:id].present?
  end
end