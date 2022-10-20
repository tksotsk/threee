module ThemesHelper
  def form_url
    if action_name == "new"
      project_themes_path
    elsif action_name == "edit"
      theme_path
    end
  end
end
