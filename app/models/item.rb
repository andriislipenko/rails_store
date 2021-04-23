class Item < ApplicationRecord
  has_many :order_descriptions, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }

  def self.search(query)
    where('lower(name) LIKE :query', query: "%#{query.downcase}%")
  end
end
