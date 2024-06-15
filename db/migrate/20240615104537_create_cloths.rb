class CreateCloths < ActiveRecord::Migration[7.1]
  def change
    create_table :cloths do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
