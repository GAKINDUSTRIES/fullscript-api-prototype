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

class Product < ApplicationRecord
  enum status: %w[unavailable available].freeze

  belongs_to :brand
  belongs_to :category
  has_many :variants, dependent: :destroy

  validates :name, :status, presence: true

  after_create :brand_status_callback
  after_update :brand_status_callback, if: :brand_id_changed? || :status_changed?
  after_destroy :brand_status_callback

  scope :available, -> { where(status: :available) }

  def check_status
    variants.with_units.count.zero? ? unavailable! : available!
  end

  private

  def brand_status_callback
    brand.check_status
  end
end
