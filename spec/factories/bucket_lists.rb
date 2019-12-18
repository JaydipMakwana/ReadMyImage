FactoryBot.define do
  factory :image do
    status { 1 }
    ocr_content { "MyText" }
    user { nil }
  end
end
