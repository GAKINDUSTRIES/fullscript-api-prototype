# == Schema Information
#
# Table name: brands
#
#  id     :integer          not null, primary key
#  name   :string           not null
#  status :integer          default("unavailable"), not null
#  prefix :string           not null
#

FactoryBot.define do
  factory :brand do
    name   { Faker::Name.unique.name }
    status { 'unavailable' }
  end
end
