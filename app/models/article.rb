class Article < ApplicationRecord
  belongs_to :employee

  validates :title, presence: true
  validates :content, presence: true

  scope :active, -> {
    where(deleted_at: nil)
  }
end
