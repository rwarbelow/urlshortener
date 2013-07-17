class AddClickCountToUrlsTable < ActiveRecord::Migration
  def change
    add_column :urls, :clicks, :integer, default: 0
  end
end
