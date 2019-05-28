# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#

require 'rails_helper'

describe Category do
  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build :category }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
