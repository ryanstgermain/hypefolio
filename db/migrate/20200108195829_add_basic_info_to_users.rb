class AddBasicInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string, null: true
    add_column :users, :fullname, :string, null: true
  end
end
