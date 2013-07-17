class Url < ActiveRecord::Base
  validates :original_url, :presence => true, :uniqueness => true
  validates :shortened_url, :presence => true, :uniqueness => true
  validates :description, :presence => true
end
