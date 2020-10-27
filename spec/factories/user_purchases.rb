FactoryBot.define do
  factory :user_purchase do
    postal_code    { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    area_id        { Faker::Number.between(from: 2, to: 48) }
    city           { Gimei.address.city.kanji }
    address_line_1 { "1条2丁目3番地" }
    address_line_2 { "佐藤アパート1階123号室" }
    phone_number   { Faker::Number.number(digits: 11) }
    price          { Faker::Number.between(from: 300, to: 9_999_999) }
    token          { Faker::Alphanumeric.alphanumeric(number: 30) }
  end
end
