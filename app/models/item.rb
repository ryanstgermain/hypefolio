class Item < ApplicationRecord
    belongs_to :user
    has_many :item_categories
    has_many :items, through: :item_categories
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :condition, presence: true
    validates :purchase_price, presence: true
    validates :purchase_date, presence: true
    validates :user_id, presence: true
end
