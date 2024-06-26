class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  after_commit -> { create_portfolio! }, on: :create

  validates :login, uniqueness: true
  validates :email, uniqueness: true
  validates :login, presence: true
  validates :email, presence: true

  has_one :portfolio, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users

  has_one_attached :avatar
  has_one_attached :admin_avatar

  enum role: {
    developer: 'developer',
    designer:  'designer',
    analyst:   'analyst',
    CTO:       'CTO'
  }

  def short_name
    "#{surname} #{first_name}"
  end

  def role_name
    self.CTO? ? role : role.capitalize
  end
end
