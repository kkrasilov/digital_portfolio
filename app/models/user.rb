class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  after_commit -> { create_portfolio! }, on: :create

  validates :login, uniqueness: true
  validates :email, uniqueness: true
  validates :login, presence: true
  validates :email, presence: true

  has_one :portfolio, dependent: :destroy

  has_one_attached :avatar

  def short_name
    "#{surname} #{first_name}"
  end
end
