class CreateFavoriteWebsites < ActiveRecord::Migration
  def change
    create_table :favorite_websites do |t|
      t.integer :user_id
      t.integer :url_id

      t.timestamps
  end
end
