class CreateAuthorsSources < ActiveRecord::Migration
  def self.up
    create_table :authors_sources, :id => false do |t|
      t.column :author_id, :integer
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :authors_sources
  end
end
