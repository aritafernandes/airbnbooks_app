class Book < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  has_many :reviews, dependent: :destroy
  validates :details, length: { maximum: 500 }
end
