class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :tickettype, foreign_key: true
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.string :name
      t.text :description
      t.integer :urgency
      t.date :date_requested
      t.integer :status
      t.string :relevant_url
      t.integer :resolution

      t.timestamps
    end

  end
end
