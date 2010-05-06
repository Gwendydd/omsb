class Authorship < ActiveRecord::Base
  belongs_to :source
  belongs_to :author

end
