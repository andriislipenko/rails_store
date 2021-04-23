class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :order_descriptions, through: :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true

  enum role: { user: 'use', admin: 'admin'}

  scope :all_except, -> (user) do
    User.where.not(id: user.id)
  end
end
