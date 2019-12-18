FactoryBot.define do
  factory :bucket_list do
    status { 1 }
    ocr_content { "MyText" }
    user { nil }
  end
end
