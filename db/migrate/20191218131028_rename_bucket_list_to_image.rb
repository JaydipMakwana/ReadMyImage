class RenameBucketListToImage < ActiveRecord::Migration[6.0]
  def change
    rename_table :bucket_lists, :images
  end
end
