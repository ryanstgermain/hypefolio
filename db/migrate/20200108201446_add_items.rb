class AddItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :size
      t.string :condition
      t.decimal :purchase_price, :precision => 8, :scale => 2
      t.date :purchase_date
      t.integer :user_id
      t.timestamps
    end
  end
end
