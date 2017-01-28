class CreateTickettypes < ActiveRecord::Migration[5.0]
  def self.up
    create_table :tickettypes do |t|
      t.string :name

      t.timestamps
    end
    Tickettype.create(name: 'Bug')
    Tickettype.create(name: 'Feature request')
    Tickettype.create(name: 'General question or inquiry')
  end
  
  def self.down
    drop_table :tickettypes
  end
end
