class DropJoinTables < ActiveRecord::Migration
  def self.up
    drop_table :countries_sources
    drop_table :authors_sources
    drop_table :languages_sources
    drop_table :sources_types
    drop_table :sources_subjects
  end

  def self.down
  end
end
