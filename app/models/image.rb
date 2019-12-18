class Image < ApplicationRecord
  enum status: { pending: 0, completed: 1 }

  has_one_attached :photo
  belongs_to :user
end
