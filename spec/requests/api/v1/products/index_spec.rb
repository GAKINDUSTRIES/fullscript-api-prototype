require 'rails_helper'

describe 'GET api/v1/products', type: :request do
  let!(:user) { create :user }
  let!(:available_products) { create_list :product, 10, status: :available }
  let!(:unavailable_products) { create_list :product, 10, status: :unavailable }

  before do
    @rated_available_products = []
    available_products.first(5).each do |product|
      @rated_available_products.push(create(:rate, user: user, product: product))
    end

    unavailable_products.first(3).each do |product|
      create :rate, user: user, product: product
    end

    get api_v1_products_path, headers: auth_headers, as: :json
  end

  it 'returns success' do
    expect(response).to have_http_status(:success)
  end

  it 'returns all the available products' do
    expect(json[:products].map { |e| e[:product][:id] }).to match_array available_products.map(&:id)
  end

  it 'returns all the id of the rated products' do
    expect(json[:products].map { |e| e[:product][:rate_id] }.compact)
      .to match_array @rated_available_products.map(&:id)
  end
end
