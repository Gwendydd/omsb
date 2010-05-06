class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :editor
      t.boolean :trans_english
      t.boolean :trans_french
      t.boolean :trans_other
      t.boolean :trans_none
      t.string :text_name
      t.integer :date_begin
      t.integer :date_end
      t.string :region
      t.boolean :link
      t.boolean :app_facsimile
      t.integer :country_id
      t.integer :author_id
      t.integer :language_id
      t.integer :type_id
      t.integer :subject_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :searches
  end
end
