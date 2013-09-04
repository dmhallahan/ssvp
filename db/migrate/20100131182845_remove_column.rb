class RemoveColumn < ActiveRecord::Migration
  def self.up
    remove_column(:teams, :pairing)
  end

  def self.down
  end
end
