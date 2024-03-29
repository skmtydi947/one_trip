FactoryBot.define do
  factory :user do
    name { Faker::Name.initials(number: 6) }
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end