class CreateVincentians < ActiveRecord::Migration
  def self.up
    create_table :vincentians do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :phone_number
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :vincentians
  end
end
