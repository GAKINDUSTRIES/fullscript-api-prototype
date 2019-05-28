# == Schema Information
#
# Table name: brands
#
#  id     :integer          not null, primary key
#  name   :string           not null
#  status :integer          default(0), not null
#  prefix :integer          not null
#

class Brand < ApplicationRecord
  enum status: %w[unavailable available].freeze

  before_validation :assign_prefix, if: :name_changed?

  validates :name, :status, :prefix, presence: true
  validates :prefix, :name, uniqueness: true

  private

  def assign_prefix
    self.prefix = Digest::SHA1.hexdigest(name)
  end
end
