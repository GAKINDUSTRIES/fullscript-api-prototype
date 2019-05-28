# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  status       :integer          default("unavailable"), not null
#  brand_id     :integer
#  category_id  :integer
#  current_rate :float            default(0.0)
#  rates_count  :integer
#  image        :string
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#

class Product < ApplicationRecord
  include Uploadable

  mount_base64_uploader :image, ImageUploader

  enum status: %w[unavailable available].freeze

  belongs_to :brand
  belongs_to :category
  has_many :variants, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :users, through: :rates

  validates :name, :status, presence: true

  after_create :brand_status_callback
  after_update :brand_status_callback, if: :brand_id_changed? || :status_changed?
  after_destroy :brand_status_callback

  scope :rated_by, (lambda do |user_id|
    user_rates = Rate.where(user_id: user_id).to_sql

    select('products.*', 'r.id as rate_id', 'r.value as rate_value')
      .joins("LEFT JOIN (#{user_rates}) AS r ON products.id = r.product_id")
      .available
      .order(id: :desc)
  end)

  scope :available, -> { where(status: :available) }

  def check_status
    variants.with_units.count.zero? ? unavailable! : available!
  end

  def update_rate(new_rate)
    self.current_rate = 0 if current_rate.nil?
    update! current_rate: (current_rate * (rates_count - 1) + new_rate) / rates_count
  end

  private

  def brand_status_callback
    brand.check_status
  end
end
