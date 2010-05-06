class ChangeIsbnToString < ActiveRecord::Migration
  def self.up
    change_column :sources, :isbn, :string
  end

  def self.down
    change_column :sources, :isbn, :integer
  end
end
