class Item < ApplicationRecord
  has_many :order_descriptions, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }

  scope :search_by_name, -> (query) do
    where('lower(name) LIKE :query', query: "%#{query.downcase}%")
  end
end
