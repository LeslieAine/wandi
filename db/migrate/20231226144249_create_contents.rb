class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.bigint :user_id, null: false
      t.string :title
      t.text :description
      t.decimal :price
      t.string :url
      t.boolean :isPaid
      t.jsonb :purchases, default: []

      t.index [:user_id], name: "index_contents_on_user_id"

      t.timestamps
    end
  end
end
