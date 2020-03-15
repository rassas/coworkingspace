class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :biography
      t.integer :status
      
      t.datetime :confirmed_at
      t.string :confirmation_token
      t.datetime :confirmation_sent_at

      t.references :coworking_space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
