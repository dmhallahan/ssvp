class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :phone_number
      t.integer :adults
      t.integer :children
      t.text :notes
      t.text :delivery_notes

      t.timestamps
    end
  end

  def self.down
    drop_table :recipients
  end
end
