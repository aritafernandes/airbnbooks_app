class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :details
      t.string :author
      t.string :year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
