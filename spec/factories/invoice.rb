FactoryBot.define do
  factory :invoice do
    number { Faker::Number.number(digits: 8) }
    date { "2023-01-18" }
    company { Faker::Company.name }
    charge_for { Faker::Name.name }
    total_in_cents { Faker::Number.between(from: 1_00, to: 10000_00) }
    emails { [Faker::Internet.email, Faker::Internet.email] }

    factory :invalid_invoice do
      number { nil }
      emails { [] }
    end
  end
end