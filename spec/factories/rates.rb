# == Schema Information
#
# Table name: rates
#
#  id         :integer          not null, primary key
#  value      :float            not null
#  user_id    :integer
#  product_id :integer
#
# Indexes
#
#  index_rates_on_product_id              (product_id)
#  index_rates_on_user_id                 (user_id)
#  index_rates_on_user_id_and_product_id  (user_id,product_id)
#

FactoryBot.define do
  factory :rate do
    value   { Random.rand(0..5) }
    user    { create :user }
    product { create :product }
  end
end
