FactoryBot.define do
  factory :brand do
    name   { Faker::Name.name }
    status { 'available' }
  end
end
