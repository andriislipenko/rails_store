class Item < ApplicationRecord
  def self.search(query)
    where('lower(name) LIKE :query', query: "%#{query.downcase}%")
  end
end
