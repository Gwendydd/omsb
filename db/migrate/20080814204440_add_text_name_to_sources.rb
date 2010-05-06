class AddTextNameToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :text_name, :text
  end

  def self.down
    remove_column :sources, :text_name
  end
end
