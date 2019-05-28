module Api
  module V1
    class RatesController < Api::V1::ApiController
      helper_method :product

      def create
        current_user.rates.create! rate_params
        head :created
      end

      private

      def rate_params
        params.require(:rate)
              .permit(:value)
              .merge!(product_id: params[:product_id])
      end
    end
  end
end
