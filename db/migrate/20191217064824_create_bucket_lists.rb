class CreateBucketLists < ActiveRecord::Migration[6.0]
  def change
    create_table :bucket_lists do |t|
      t.integer :status, default: 0, null: false
      t.text :ocr_content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
