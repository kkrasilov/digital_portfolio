class Award < ApplicationRecord
  belongs_to :portfolio

  validates :title, presence: true
  validates :file, presence: true

  has_one_attached :file
end
