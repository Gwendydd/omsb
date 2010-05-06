class ChangeSearchesFacsimileToBoolean < ActiveRecord::Migration
  def self.up
    change_column :searches, :facsimile, :boolean
  end

  def self.down
    change_column :searches, :facsimile, :string
  end
end
