class AddTeamNumToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :team_num, :integer
  end

  def self.down
    remove_column :teams, :team_num
  end
end
