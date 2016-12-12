class ForumsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)
    if @forum.save
      redirect_to @forum
    else
      render :new
    end
  end

  def index
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update(forum_params)
      redirect_to @forum
    else
      render :edit
    end
  end

  def destroy
  end

  private

    def forum_params
      params.require(:forum).permit(:title, :content)
    end
end

