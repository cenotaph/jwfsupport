class AddSystemToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :is_system, :boolean, null: false, default: false
  end
end
