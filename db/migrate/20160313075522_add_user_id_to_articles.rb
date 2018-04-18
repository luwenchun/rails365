class AddUserIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :user, index: true, foreign_key: true
  end
end
