class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts do |t|
      t.text :topics
      t.text :interests
      t.text :languages
      t.integer :links, array: true, default: [] 
      t.references :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
