FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    token  { SecureRandom.hex }
    token_to_confirm { nil }

    factory :user_to_confirm do
      token_to_confirm { SecureRandom.hex }
    end
  end
end