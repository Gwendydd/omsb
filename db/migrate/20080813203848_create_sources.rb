class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources, :force => true do |t|
      t.column :my_id,         :string,   :limit => 20
      t.column :editor,        :string
      t.column :title,         :string
      t.column :publication,   :string
      t.column :pub_date,      :string,   :limit => 20
      t.column :isbn,          :integer,  :limit => 13
      t.column :text_pages,    :integer,  :limit => 5
      t.column :trans_english, :boolean,  :default => 0
      t.column :trans_french,  :boolean,  :default => 0
      t.column :trans_other,   :boolean,  :default => 0
      t.column :trans_none,    :boolean,  :default => 0
      t.column :date_begin,    :integer,  :limit => 4
      t.column :date_end,      :integer,  :limit => 4
      t.column :region,        :string
      t.column :archive,       :string
      t.column :link,          :string
      t.column :app_index,     :boolean,  :default => 0
      t.column :app_glossary,  :boolean,  :default => 0
      t.column :app_appendix,  :boolean,  :default => 0
      t.column :app_bibliography, :boolean,  :default => 0
      t.column :app_facsimile, :boolean,  :default => 0
      t.column :app_intro,     :boolean,  :default => 0
      t.column :comments,      :text
      t.column :intro_summary, :text
      t.column :addenda,       :text
      t.column :live,          :boolean,  :default => 0

      t.column :user_id,       :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
