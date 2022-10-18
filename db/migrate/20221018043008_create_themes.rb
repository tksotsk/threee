class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|
      t.string :first_theme, null: false, default: ""
      t.string :second_theme, null: false, default: ""
      t.string :third_theme, null: false, default: ""

      t.timestamps
    end
  end
end
