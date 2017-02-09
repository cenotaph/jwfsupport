class AddAssignedIdToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :assigned_id, :integer, null: false, default: 1
  end
end
