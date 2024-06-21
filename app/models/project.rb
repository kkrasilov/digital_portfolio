class Project < ApplicationRecord
  has_rich_text :content
  has_one_attached :image

  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  validates :title, presence: true

  enum status: {
    draft: 'draft',
    done:  'done'
  }
end
