class Director < ActiveRecord::Base
  has_paper_trail
  belongs_to :company
  has_many :documents
  validates_presence_of :surname
  validates_presence_of :company_id
end
