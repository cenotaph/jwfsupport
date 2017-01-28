class CreateScreenshots < ActiveRecord::Migration[5.0]
  def change
    create_table :screenshots do |t|
      t.string :image
      t.integer :image_size, length: 8
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
