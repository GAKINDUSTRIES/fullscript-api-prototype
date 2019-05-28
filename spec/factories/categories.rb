# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.name }
  end
end
