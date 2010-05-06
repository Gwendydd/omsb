class Author < ActiveRecord::Base
  has_many :authorships
  has_many :sources, :through => :authorships

  acts_as_textiled :bio

end
