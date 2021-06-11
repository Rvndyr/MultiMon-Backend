class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views do |t|
      t.integer :user_id
      t.string :username

      t.timestamps
    end
  end
end
