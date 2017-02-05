class AddCommithashToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commit_hash, :string
    add_column :projects, :github_user, :string
    add_column :projects, :github_repo, :string
  end
end
