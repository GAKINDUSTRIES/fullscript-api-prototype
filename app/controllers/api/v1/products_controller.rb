module Api
  module V1
    class ProductsController < Api::V1::ApiController
      def index
        @products = Product.rated_by(current_user.id).page(params[:page])
      end
    end
  end
end
