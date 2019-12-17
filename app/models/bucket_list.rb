class BucketList < ApplicationRecord
  enum status: { pending: 0, completed: 1 }

  has_many_attached :images
  belongs_to :user

  before_create :ocr_processing

  def ocr_processing
  end
end
