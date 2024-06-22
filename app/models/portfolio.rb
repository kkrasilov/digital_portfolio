class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :awards, dependent: :destroy
end
