require 'rails_helper'

describe 'POST api/v1/products/:product_id/rate', type: :request do
  let!(:user)    { create :user }
  let!(:product) { create :product }
  let(:params)   { { rate: { value: 5 } } }

  context 'when user does not rate the product yet' do
    it 'returns a successful response' do
      post api_v1_product_rate_path(product_id: product.id),
           params: params, headers: auth_headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it 'creates the rate relation' do
      expect {
        post api_v1_product_rate_path(product_id: product.id),
             params: params, headers: auth_headers, as: :json
      }.to change { Rate.count }.by(1)
    end
  end

  context 'has already rate the product' do
    before { create :rate, user: user, product: product }

    it 'does not return a successful response' do
      post api_v1_product_rate_path(product_id: product.id),
           params: params, headers: auth_headers, as: :json
      expect(response).not_to have_http_status(:created)
    end

    it 'does NOT create the rate relation' do
      expect {
        post api_v1_product_rate_path(product_id: product.id),
             params: params, headers: auth_headers, as: :json
      }.to change { Rate.count }.by(0)
    end
  end
end
