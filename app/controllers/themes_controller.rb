class ThemesController < ApplicationController
  before_action :set_theme, only: %i[ show edit update destroy ]

  # GET /themes or /themes.json
  def index
    @project = Project.find(params[:project_id])
    @themes = Theme.all
  end

  # GET /themes/1 or /themes/1.json
  def show
    @project = Project.find(params[:project_id])
  end

  # GET /themes/new
  def new
    
    @project = Project.find(params[:project_id])
    @theme = Project.find(params[:project_id]).themes.order(created_at: :desc).first.dup
  end

  # GET /themes/1/edit
  def edit
  end

  # POST /themes or /themes.json
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

  # PATCH/PUT /themes/1 or /themes/1.json
  def update
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to theme_url(@theme), notice: "Theme was successfully updated." }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1 or /themes/1.json
  def destroy
    @theme.destroy

    respond_to do |format|
      format.html { redirect_to themes_url, notice: "Theme was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_theme
    @theme = Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:first_theme, :second_theme, :third_theme)
  end
end
