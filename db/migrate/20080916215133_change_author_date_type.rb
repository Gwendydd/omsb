class ChangeAuthorDateType < ActiveRecord::Migration
  def self.up
    change_column :authors, :date_type, :string, :limit => 12
  end

  def self.down
    change_column :authors, :date_type, :string, :limit => 1
  end
end
