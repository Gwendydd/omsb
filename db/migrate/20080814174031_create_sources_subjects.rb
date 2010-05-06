class CreateSourcesSubjects < ActiveRecord::Migration
  def self.up
    create_table :sources_subjects, :id => false do |t|
      t.column :subject_id, :integer
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :sources_subjects
  end
end
