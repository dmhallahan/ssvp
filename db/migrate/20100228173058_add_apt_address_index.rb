class AddAptAddressIndex < ActiveRecord::Migration
  def self.up
    add_index(:recipients, [:address, :apt], :unique => true, :name => "apt_address_index") 
  end

  def self.down
    remove_index(:recipients, :name => "apt_address_index")
  end
end
