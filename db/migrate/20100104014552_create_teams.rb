class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer :vincentian_id
      t.integer :delivery_id
      t.integer :pairing

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
