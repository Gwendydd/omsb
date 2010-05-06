class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types, :force => true do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :types
  end
end
