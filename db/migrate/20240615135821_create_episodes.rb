class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cloth, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
