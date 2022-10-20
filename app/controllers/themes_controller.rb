class ThemesController < ApplicationController
  before_action :set_theme, only: %i[ show edit update ]

  def index
    @project = Project.find(params[:project_id])
    @themes = @project.themes.order(created_at: :desc)
  end

  def new
    @project = Project.find(params[:project_id])
    @now_theme = @project.themes.order(created_at: :desc).first
    @theme = Project.find(params[:project_id]).themes.order(created_at: :desc).first.dup
  end

  def show
    @themes = @theme.project.themes.order(created_at: :desc)
    @now_theme = @themes.first
    @theme_ids = @themes.map{|t| t.id }
    @theme_ids_num = @theme_ids.index(@theme.id)
    @back_id = @theme_ids[@theme_ids.index(@theme.id)+1]
    @next_id = @theme_ids[@theme_ids.index(@theme.id)-1]
    @back_id ||= @theme_ids[@theme_ids.index(@theme.id)]
    @next_id ||= @theme_ids[@theme_ids.index(@theme.id)]
  end

  def edit
    @project = @theme.project
    @now_theme = @project.themes.order(created_at: :desc).first
  end

  def create
    @project = Project.find(params[:project_id])
    @theme = @project.themes.new(theme_params)

    respond_to do |format|
      if equal_now(@theme, @project.themes.order(created_at: :desc).first)
        format.html { redirect_to new_project_theme_path, notice: "現在のテーマと同じです"}
      elsif @theme.save
        format.html { redirect_to theme_path(@theme), notice: "Theme was successfully created." }
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

  private

  def set_theme
    @theme = Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:first_theme, :second_theme, :third_theme)
  end

  def equal_now(new, now)
    new.first_theme == now.first_theme && new.second_theme == now.second_theme && new.third_theme == now.third_theme
  end

end
