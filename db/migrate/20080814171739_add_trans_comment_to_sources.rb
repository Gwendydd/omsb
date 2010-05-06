class AddTransCommentToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :trans_comment, :string
  end

  def self.down
    remove_column :sources, :trans_comment
  end
end
