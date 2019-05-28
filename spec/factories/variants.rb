# == Schema Information
#
# Table name: products
#
#  id       :integer          not null, primary key
#  name     :string           not null
#  status   :integer          default("unavailable"), not null
#  brand_id :integer
#
# Indexes
#
#  index_products_on_brand_id  (brand_id)
#

FactoryBot.define do
  factory :variant do
    units           { Random.rand(0..99) }
    unit_of_measure { 'capsules' }
    image           { Rails.root.join('spec/support/blank.jpg').open }
    product         { create :product }
  end
end
