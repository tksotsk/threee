class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Project.order(created_at: :desc).includes(:user, :themes)
  end

  def show
    @themes = @project.themes.order(created_at: :desc)
    @theme = @themes.first
    @theme_ids = @themes.map{|t| t.id }
    @back_id = @theme_ids[@theme_ids.index(@theme.id)+1]
    @next_id = @theme_ids[@theme_ids.index(@theme.id)-1]
  end

  def new
    @project = Project.new
    @project.themes.new
  end

  def create
    @project = current_user.projects.build(project_params)
    @theme = @project.themes.order(created_at: :desc).first
    respond_to do |format|
      if @project.save
        format.html { redirect_to  projects_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @projects = current_user.projects.order(created_at: :desc).includes(:user, :themes)
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to  my_page_path(@project.user), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to  projects_path, notice: "Theme was successfully destroyed." }
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
