class FavoriteWebsite < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :url
end
