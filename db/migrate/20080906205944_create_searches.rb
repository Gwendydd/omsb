class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches, :force => true do |t|
      t.string :text_name
      t.string :author
      t.string :editor
      t.string :link
      t.string :facsimile
      t.integer :date_begin
      t.integer :date_end
      t.string :language
      t.boolean :trans_none
      t.boolean :trans_english
      t.boolean :trans_french
      t.boolean :trans_other
      t.string :country
      t.string :region
      t.string :type
      t.string :subject
      t.timestamps
    end
  end
  
  def self.down
    drop_table :searches
  end
end
