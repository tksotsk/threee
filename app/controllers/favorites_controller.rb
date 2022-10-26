class FavoritesController < ApplicationController
  before_action :set_project, only: :destroy

  def index
    if params[:project_id]
      current_user.favorites.find_by(project_id: params[:project_id]).destroy!
      flash.now[:notice] = "お気に入りが解除されました"
    end
    @user = current_user
    @projects = @user.favorite_projects.all 
  end
  
  def create
    @favorite = current_user.favorites.build(project_id: params[:project_id])
    @project = @favorite.project
    @favorite.save
  end

  def destroy
    current_user.favorites.find_by(project_id: params[:id]).destroy!
  end
  
  private

  def set_project
    @project = Project.find(params[:id])
  end
end
