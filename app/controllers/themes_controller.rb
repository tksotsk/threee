class ThemesController < ApplicationController
  before_action :set_theme, only: %i[ edit update ]

  def index
    @project = Project.find(params[:project_id])
    @themes = Theme.all
  end

  def new
    @project = Project.find(params[:project_id])
    @theme = Project.find(params[:project_id]).themes.order(created_at: :desc).first.dup
  end

  def edit
  end

  def create
    @project = Project.find(params[:project_id])
    @theme = @project.themes.new(theme_params)

    respond_to do |format|
      if @theme.save
        format.html { redirect_to project_path(@project), notice: "Theme was successfully created." }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to project_path(@theme.project.id), notice: "Theme was successfully updated." }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  privat

  def set_theme
    @theme = Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:first_theme, :second_theme, :third_theme)
  end
end
