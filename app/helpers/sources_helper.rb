module SourcesHelper

  def add_country_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :countries, :partial => 'country', :object => Country.new
    end
  end

  def add_language_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :languages, :partial => 'language', :object => Language.new
    end
  end
  
  def add_subject_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :subjects, :partial => 'subject', :object => Subject.new
    end
  end
 
  def add_type_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :types, :partial => 'type', :object => Type.new
    end
  end

  def add_authorship_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :authorships, :partial => 'authorship', :object => Authorship.new
    end
  end

end
