# == Schema Information
#
# Table name: brands
#
#  id     :integer          not null, primary key
#  name   :string           not null
#  status :integer          default("unavailable"), not null
#  prefix :string           not null
#

class Brand < ApplicationRecord
  enum status: %w[unavailable available].freeze

  before_validation :assign_prefix, if: :name_changed?

  has_many :products, dependent: :destroy

  validates :name, :status, :prefix, presence: true
  validates :prefix, :name, uniqueness: true

  def check_status
    products.available.count.zero? ? unavailable! : available!
  end

  private

  def assign_prefix
    self.prefix = Digest::SHA1.hexdigest(name)
  end
end
