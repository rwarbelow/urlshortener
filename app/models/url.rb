class Url < ActiveRecord::Base
  validates :original_url, :uniqueness => true
  validate  :valid_url_syntax
  validate  :valid_url
  validates :shortened_url, :presence => true, :uniqueness => true
  validates :description, :presence => true
  has_many :admirers, :class_name => "User", :dependent => :destroy


  include SecureRandom 


  def self.shorten(params)
    short_url = SecureRandom.hex(3)
    Url.new(:original_url => params[:url][:original_url],
      :shortened_url => short_url,
      :description => params[:url][:description])
  end

  def valid_url_syntax
    if original_url.present? && original_url !~/([http]|[https])+\:\/\//i 
      errors.add(:original_url, 'Please put either http:// or https:// in your url')
    end
  end

  def valid_url

    url_test = Curl::Easy.new(original_url) do |curl|
      curl.follow_location = true
      curl.head = true
    end 
    # binding.pry           
    begin
      unless url_test.perform == true && url_test.response_code == 200
        errors.add(:original_url, 'is not a valid url')
      end
    rescue 
      errors.add(:original_url, 'is not a valid url')
    end
  end
end

