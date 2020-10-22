FactoryBot.define do
  name = Gimei.name
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'abc123' }
    password_confirmation { password }
    family_name           { name.last.kanji }
    first_name            { name.first.kanji }
    family_name_kana      { name.last.katakana }
    first_name_kana       { name.first.katakana }
    birthday              { Faker::Date.birthday }
  end
end
