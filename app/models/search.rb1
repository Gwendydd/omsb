class Search < ActiveRecord::Base
  def sources
    @sources ||= find_sources
  end

  def find_sources
    Sources.find(:all, :conditions => conditions)
  end

  def text_name_conditions
    ["sources.text_name LIKE ?", "%#{text_name}%"] unless text_name.blank?
  end

  def editor_conditions
    ["sources.editor LIKE ?", "%#{editor}%"] unless editor.blank?
  end

  def region_conditions
    ["sources.region LIKE ?", "%#{region}%"] unless region.blank?
  end

  def facsimile_conditions
  end

  def trans_none_conditions
  end

  def trans_english_conditions
  end

  def trans_french_conditions
  end

  def trans_other_conditions
  end  

author:string 
link:string 
date_begin:integer 
date_end:integer 
language:string 
country:string 
type:string 
subject:string




end
