class AddVisitToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :visit_count, :integer, default: 0
  end
end
