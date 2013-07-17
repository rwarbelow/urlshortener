class Url < ActiveRecord::Base
  validates :original_url, :presence => true, :uniqueness => true
  validates :shortened_url, :presence => true, :uniqueness => true
  validates :description, :presence => true

  include SecureRandom 

  def self.shorten(params)
    short_url = SecureRandom.hex(3)
    Url.create(:original_url => params[:url][:original_url],
              :shortened_url => short_url,
              :description => params[:url][:description])
  end
end
