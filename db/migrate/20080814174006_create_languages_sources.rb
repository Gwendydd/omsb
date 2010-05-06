class CreateLanguagesSources < ActiveRecord::Migration
  def self.up
    create_table :languages_sources, :id => false do |t|
      t.column :language_id, :integer
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :languages_sources
  end
end
