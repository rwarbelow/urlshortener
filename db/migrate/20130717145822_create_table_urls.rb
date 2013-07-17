class CreateTableUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :original_url
      t.string :shortened_url
      t.string :description

      t.timestamps
    end
  end
end
