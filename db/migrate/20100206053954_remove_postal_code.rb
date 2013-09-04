class RemovePostalCode < ActiveRecord::Migration
  def self.up
    remove_column(:recipients, :postal_code)
  end

  def self.down
  end
end
