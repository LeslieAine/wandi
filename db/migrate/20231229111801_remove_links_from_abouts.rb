class RemoveLinksFromAbouts < ActiveRecord::Migration[7.0]
  def change
    remove_column :abouts, :links
  end
end
