# == Schema Information
#
# Table name: products
#
#  id       :integer          not null, primary key
#  name     :string           not null
#  status   :integer          default("unavailable"), not null
#  brand_id :integer
#
# Indexes
#
#  index_products_on_brand_id  (brand_id)
#

require 'rails_helper'

describe Product do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }
    it { is_expected.to have_many(:variants).dependent(:destroy) }
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
end
