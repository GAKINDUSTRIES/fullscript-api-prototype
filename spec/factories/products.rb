# == Schema Information
#
# Table name: brands
#
#  id     :integer          not null, primary key
#  name   :string           not null
#  status :integer          default("unavailable"), not null
#  prefix :integer          not null
#

FactoryBot.define do
  factory :product do
    name   { Faker::Name.unique.name }
    status { 'available' }
    brand  { create :brand }
  end
end
