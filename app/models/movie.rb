class Movie < ApplicationRecord
  belongs_to :user
  has_many :review
  validates :title, presence: true
end
