class CreateCountriesSources < ActiveRecord::Migration
  def self.up
    create_table :countries_sources, :id => false, :force => true do |t|
      t.column :country_id, :integer
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :countries_sources
  end
end
