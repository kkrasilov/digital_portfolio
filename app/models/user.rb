class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  validates :login, uniqueness: true
  validates :email, uniqueness: true
  validates :login, presence: true
  validates :email, presence: true
end
