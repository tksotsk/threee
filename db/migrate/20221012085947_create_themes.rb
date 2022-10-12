class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|
      t.string :theme
      t.text :content

      t.timestamps
    end
  end
end