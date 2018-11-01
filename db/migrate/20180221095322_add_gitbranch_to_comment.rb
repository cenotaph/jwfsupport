class AddGitbranchToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :branch, :string, default: 'master', null: false
  end
end
