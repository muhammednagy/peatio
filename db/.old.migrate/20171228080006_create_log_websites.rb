class CreateLogWebsites < ActiveRecord::Migration
  def change
    create_table :log_websites do |t|
      t.string :method
      t.string :path
      t.string :format
      t.string :controller
      t.string :action
      t.string :status
      t.string :duration
      t.string :view
      t.string :db
      t.string :location

      t.timestamps
    end
  end
end
