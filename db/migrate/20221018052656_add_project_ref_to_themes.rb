class AddProjectRefToThemes < ActiveRecord::Migration[6.1]
  def change
    add_reference :themes, :project, null: false, foreign_key: true
  end
end
