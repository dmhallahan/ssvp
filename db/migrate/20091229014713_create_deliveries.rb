class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.date :delivery_date
      t.text :comment
      t.integer :bags
      t.integer :recipient_id
      

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
