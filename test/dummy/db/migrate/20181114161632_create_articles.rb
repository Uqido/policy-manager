class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.references :user, index: true, foreign_key: true
      t.string :subtitle
      t.string :description

      t.timestamps null: false
    end
  end
end
