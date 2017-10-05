class AddAttachmentToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :attachment, :string
    add_column :tickets, :attachment_size, :integer, length: 8
    add_column :tickets, :attachment_content_type, :string
  end
end
