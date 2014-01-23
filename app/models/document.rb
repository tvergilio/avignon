class Document < ActiveRecord::Base
  has_paper_trail
  belongs_to :director
  validates_presence_of :name
end
