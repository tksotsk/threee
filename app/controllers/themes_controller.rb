class ThemesController < ApplicationController
  before_action :set_theme, only: %i[ show edit update ]
  before_action :check_user, only: %i[edit update destory]

  def index
    @project = Project.find(params[:project_id])
    @user = @project.user
    @themes = @project.themes.order(created_at: :desc)
  end

  def new
    @project = Project.find(params[:project_id])
    @user = @project.user
    @now_theme = @project.themes.order(created_at: :desc).first
    @theme = Project.find(params[:project_id]).themes.order(created_at: :desc).first.dup
  end

  def show
    @user = @theme.project.user
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
    @user = @project.user
    @now_theme = @project.themes.order(created_at: :desc).first
  end

  def create
    @project = Project.find(params[:project_id])
    @user = @project.user
    @theme = @project.themes.new(theme_params)
    

    respond_to do |format|
      if equal_now(@theme, @project.themes.order(created_at: :desc).first)
        format.html { redirect_to new_project_theme_path, notice: "現在のテーマと同じです"}
      elsif @theme.save
        format.html { redirect_to three_path(@user, @theme), notice: "テーマが変更されました" }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html {redirect_to new_project_theme_path, notice: "テーマの変更に失敗しました" }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = @theme.user
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to three_path(@user, @theme), notice: "テーマが修正されました" }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def check_user
    unless @theme.project.user_id == current_user.id
      redirect_to my_page_path(@theme.project.user_id), notice: '他のユーザーではできない処理です'
    end
  end

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
