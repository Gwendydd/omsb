class CreateSourcesTypes < ActiveRecord::Migration
  def self.up
    create_table :sources_types, :id => false do |t|
      t.column :type_id, :integer
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :sources_types
  end
end
