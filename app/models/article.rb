class Article < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true

  scope :active, -> {
    where(deleted_at: nil)
  }
end
