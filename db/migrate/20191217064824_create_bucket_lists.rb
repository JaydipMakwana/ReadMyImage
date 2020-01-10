class CreateBucketLists < ActiveRecord::Migration[6.0]
  def change
    create_table :bucket_lists do |t|
      t.integer :status, default: 0, null: false
      t.text :ocr_content

      t.timestamps
    end
  end
end
