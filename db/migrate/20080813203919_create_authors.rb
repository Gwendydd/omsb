class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors, :force => true do |t|
      t.string :name
      t.string :dates
      t.string :alias
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :authors
  end
end
