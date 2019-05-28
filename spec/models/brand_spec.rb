require 'rails_helper'

describe Brand do
  describe 'validations' do
    subject { build :brand }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:prefix) }
    it { is_expected.to validate_uniqueness_of(:prefix) }
    it { is_expected.to validate_uniqueness_of(:name) }
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
