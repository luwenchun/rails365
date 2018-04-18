class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :desc
      t.belongs_to :group, index: true
      t.string :image
      t.string :url

      t.timestamps null: false
    end
  end
end
