class RemoveColumnToFavorite < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :favorite, :integer
  end
end
