class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :ticket, foreign_key: true
      t.references :user, foreign_key: true
      t.string :attachment
      t.integer :attachment_size, length: 8
      t.string :attachment_content_type
      t.string :screenshot
      t.integer :screenshot_size, length: 8
      t.integer :screenshot_width
      t.integer :screenshot_height
      t.string :screenshot_content_type
      t.text :description

      t.timestamps
    end
  end
end
