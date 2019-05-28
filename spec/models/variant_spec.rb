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

require 'rails_helper'

describe Variant do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    subject { build :variant }

    it { is_expected.to validate_presence_of(:units) }
  end

  describe '#product_status_callback' do
    context 'when unit is changed' do
      let(:product) { create :product }

      context 'when unit change from 0 to 1' do
        let!(:variant) { create :variant, units: 0, product: product }

        it 'calls product.check_status' do
          expect(product).to receive(:check_status)
          variant.update! units: 1
        end
      end

      context 'when unit change from 1 to 0' do
        let!(:variant) { create :variant, units: 1, product: product }

        it 'calls product.check_status' do
          expect(product).to receive(:check_status)
          variant.update! units: 0
        end
      end

      context 'when unit change from two numbers different from 0' do
        let!(:variant) { create :variant, units: 2, product: product }

        it 'calls product.check_status' do
          expect(product).not_to receive(:check_status)
          variant.update! units: 1
        end
      end
    end
  end
end
