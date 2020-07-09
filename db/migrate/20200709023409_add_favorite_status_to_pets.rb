class AddFavoriteStatusToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :favorite_status, :boolean, default: false
  end
end
