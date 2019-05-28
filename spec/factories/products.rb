# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  status      :integer          default("unavailable"), not null
#  brand_id    :integer
#  category_id :integer
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#

FactoryBot.define do
  factory :product do
    name   { Faker::Name.unique.name }
    status { 'available' }
    brand  { create :brand }
  end
end
