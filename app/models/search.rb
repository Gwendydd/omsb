class Search < ActiveRecord::Base
  def sources
    @sources ||= find_sources
  end

  private

  def find_sources
    Source.find(:all, 
                 :conditions => conditions, 
                 :include => :countries,
                 :include => :languages,
                 :include => :subjects,
                 :include => :types,
                 :include => :authors)
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

  def live_conditions
    ["sources.live = ?", true]
  end

  def facsimile_conditions
    ["sources.facsimile = ?", true]
  end

  def trans_none_conditions
    ["sources.trans_none = ?", true]
  end

  def trans_english_conditions
    ["sources.trans_english = ?", true]
  end

  def trans_french_conditions
    ["sources.trans_french = ?", true]
  end

  def trans_other_conditions
    ["sources.trans_other = ?", true]
  end  

  def date_begin_conditions
    ["sources.date_begin >= ?", date_begin] unless date_begin.blank?
  end

  def date_end_conditions
    ["sources.date_end <= ?", date_end] unless date_end.blank?
  end

  def country_conditions
    ["sources.countries.name LIKE ?", "%#{country}%"] unless country.blank?
  end

  def language_conditions
    ["sources.languages.name LIKE ?", "%#{language}%"] unless language.blank?
  end
 
  def type_conditions
    ["sources.types.name LIKE ?", "%#{type}%"] unless type.blank?
  end

  def subject_conditions
    ["sources.subjects.name LIKE ?", "%#{subject}%"] unless subject.blank?
  end

  def author_conditions
    ["sources.authors.name LIKE ?", "%#{author}%"] unless author.blank?
  end

  def link_conditions

  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end



end
