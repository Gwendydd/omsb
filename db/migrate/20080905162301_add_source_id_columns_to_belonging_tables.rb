class AddSourceIdColumnsToBelongingTables < ActiveRecord::Migration
  def self.up
    add_column :countries, :source_id, :integer
    add_column :languages, :source_id, :integer
    add_column :subjects, :source_id, :integer
    add_column :types, :source_id, :integer
  end

  def self.down
    remove_column :countries, :source_id
    remove_column :languages, :source_id
    remove_column :subjects, :source_id
    remove_column :types, :source_id
  end
end
