class BucketList < ApplicationRecord
  enum status: { pending: 0, completed: 1 }

  has_many_attached :images
  belongs_to :user
end
