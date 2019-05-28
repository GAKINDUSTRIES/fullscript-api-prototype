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

require 'rails_helper'

describe Rate do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    subject { build :rate }

    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_inclusion_of(:value).in_array([*0..5]) }
  end
end
