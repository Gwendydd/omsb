class Source < ActiveRecord::Base
  has_many :countries
  has_many :languages
  has_many :types
  has_many :subjects
  has_many :authorships
  has_many :authors, :through => :authorships
  belongs_to :user

  acts_as_textiled :comments, :intro_summary

  def new_country_attributes=(country_attributes)
    country_attributes.each do |attributes|
      countries.build(attributes)
    end
  end

  def new_language_attributes=(language_attributes)
    language_attributes.each do |attributes|
      languages.build(attributes)
    end
  end

  def new_subject_attributes=(subject_attributes)
    subject_attributes.each do |attributes|
      subjects.build(attributes)
    end
  end

  def new_type_attributes=(type_attributes)
    type_attributes.each do |attributes|
      types.build(attributes)
    end
  end 

  def new_authorship_attributes=(authorship_attributes)
    authorship_attributes.each do |attributes|
      authorships.build(attributes)
    end
  end

  after_update :save_countries
  after_update :save_languages
  after_update :save_subjects
  after_update :save_types
  after_update :save_authorships

  def existing_country_attributes=(country_attributes)
    countries.reject(&:new_record?).each do |country|
      attributes = country_attributes[country.id.to_s]
      if attributes
        country.attributes = attributes
      else
        countries.delete(country)
      end
    end
  end

  def save_countries
    countries.each do |country|
      country.save(false)
    end
  end

  def existing_language_attributes=(language_attributes)
    languages.reject(&:new_record?).each do |language|
      attributes = language_attributes[language.id.to_s]
      if attributes
        language.attributes = attributes
      else
        languages.delete(language)
      end
    end
  end

  def save_languages
    languages.each do |language|
      language.save(false)
    end
  end

  def existing_subject_attributes=(subject_attributes)
    subjects.reject(&:new_record?).each do |subject|
      attributes = subject_attributes[subject.id.to_s]
      if attributes
        subject.attributes = attributes
      else
        subjects.delete(subject)
      end
    end
  end

  def save_subjects
    subjects.each do |subject|
      subject.save(false)
    end
  end

  def existing_type_attributes=(type_attributes)
    types.reject(&:new_record?).each do |type|
      attributes = type_attributes[type.id.to_s]
      if attributes
        type.attributes = attributes
      else
        types.delete(type)
      end
    end
  end

  def save_types
    types.each do |type|
      type.save(false)
    end
  end

  def existing_authorship_attributes=(authorship_attributes)
    authorships.reject(&:new_record?).each do |authorship|
      attributes = authorship_attributes[authorship.id.to_s]
      if attributes
        authorship.attributes = attributes
      else
        authorship.delete(authorship)
      end
    end
  end
 
  def save_authorships
    authorships.each do |authorship|
      authorship.save(false)
    end
  end

end
