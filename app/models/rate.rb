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

class Rate < ApplicationRecord
  belongs_to :product, counter_cache: true
  belongs_to :user

  validates :value, presence: true, inclusion: { in: 0..5 }
  validates :user,
            uniqueness: { scope: :product, message: 'A product can only be rated once' }

  after_create :update_product_rate

  private

  def update_product_rate
    product.update_rate(value)
  end
end
