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
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#

require 'rails_helper'

describe Product do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:variants).dependent(:destroy) }
    it { is_expected.to have_many(:rates).dependent(:destroy) }
    it { is_expected.to have_many(:users) }
  end

  describe 'validations' do
    subject { build :product }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'callbacks' do
    context 'when name is changed' do
      let(:name) { 'Some name' }
      let(:new_name) { 'New name' }
      let!(:brand) { create :brand, name: name }

      it 'does assign a new prefix' do
        expect { brand.update! name: new_name }
          .to change { brand.prefix }
      end
    end

    context 'when name is not changed' do
      let(:status) { 'available' }
      let(:new_status) { 'unavailable' }
      let!(:brand) { create :brand, status: status }

      it 'does assign a new prefix' do
        expect { brand.update! status: new_status }
          .not_to change { brand.prefix }
      end
    end
  end

  describe '.update_product_rate' do
    let(:product) { create :product }

    before { 2.times { create :rate, value: 3.5, product: product } }

    it 'updates the product rate correctly' do
      create :rate, value: 5, product: product
      expect(product.current_rate).to eq 4
    end
  end
end
