class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url
      t.boolean :active, default: true, null: false
      t.string :slug
      t.string :icon
      t.string :icon_content_type
      t.integer :icon_size
      t.integer :icon_width
      t.integer :icon_height
      t.text :description

      t.timestamps
    end
  end
end
