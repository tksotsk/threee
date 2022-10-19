class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Project.all
  end

  def show
    @theme=@project.themes.order(created_at: :desc).first
  end

  def new
    @project = Project.new
    @project.themes.new
  end

  def create
    @project = current_user.projects.build(project_params)
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Theme was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, themes_attributes: [:first_theme, :second_theme, :third_theme])
  end
end
