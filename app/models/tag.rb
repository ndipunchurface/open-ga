class Tag < ActiveRecord::Base
  has_many :taxonomies
end
