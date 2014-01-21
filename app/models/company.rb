class Company < ActiveRecord::Base
  has_paper_trail
  has_many :directors
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :country
end
