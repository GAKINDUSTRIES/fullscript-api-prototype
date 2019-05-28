# == Schema Information
#
# Table name: brands
#
#  id     :integer          not null, primary key
#  name   :string           not null
#  status :integer          default("unavailable"), not null
#  prefix :string           not null
#

require 'rails_helper'

describe Brand do
  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build :brand }
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

    describe '.check_status' do
      let!(:brand) { create :brand }

      context 'when available products increase from 0 to 1' do
        it 'updates status to available' do
          expect { create :product, status: :available, brand: brand }
            .to change { brand.status }
            .from('unavailable')
            .to('available')
        end
      end

      context 'when available products decrease from 0 to 1' do
        let!(:product) { create :product, status: :available, brand: brand }

        it 'updates status to available' do
          expect { product.destroy! }
            .to change { brand.status }
            .from('available')
            .to('unavailable')
        end
      end
    end
  end
end
