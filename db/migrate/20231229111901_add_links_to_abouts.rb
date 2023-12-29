class AddLinksToAbouts < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :links, :jsonb, default: []
  end
end
