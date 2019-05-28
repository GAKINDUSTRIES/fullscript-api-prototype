# == Schema Information
#
# Table name: variants
#
#  id              :integer          not null, primary key
#  units           :integer          default(0), not null
#  unit_of_measure :string
#  image           :string
#  product_id      :integer
#
# Indexes
#
#  index_variants_on_product_id  (product_id)
#

FactoryBot.define do
  factory :variant do
    units           { Random.rand(0..99) }
    unit_of_measure { 'capsules' }
    image           { Rails.root.join('spec/support/blank.jpg').open }
    product         { create :product }
  end
end
