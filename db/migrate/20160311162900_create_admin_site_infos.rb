class CreateAdminSiteInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_site_infos do |t|
      t.string :key
      t.string :value
      t.string :desc

      t.timestamps null: false
    end
  end
end
