class AddRateToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :current_rate, :float, default: 0
    add_column :products, :rates_count, :integer
  end
end
