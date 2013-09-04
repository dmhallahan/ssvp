class AddAptToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :apt, :string
  end

  def self.down
    remove_column :recipients, :apt
  end
end
