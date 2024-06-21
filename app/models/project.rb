class Project < ApplicationRecord
  has_rich_text :content

  enum status: {
    draft:  :draft,
    active: :active,
  }
end
