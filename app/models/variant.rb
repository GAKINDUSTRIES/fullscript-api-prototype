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

class Variant < ApplicationRecord
  include Uploadable

  mount_base64_uploader :image, ImageUploader

  belongs_to :product

  validates :units, presence: true

  before_save :product_status_callback, if: :units_changed?

  scope :with_units, -> { where('units > 0') }

  private

  def product_status_callback
    need_change = units_was.positive? && units.zero? || units_was.zero? && units.positive?
    product.check_status if need_change
  end
end
