class AddCatalogerFieldToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :cataloger, :string    
  end

  def self.down
    remove_column :sources, :cataloger
  end
end
