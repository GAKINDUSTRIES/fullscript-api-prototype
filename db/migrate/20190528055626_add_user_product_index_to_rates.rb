class AddUserProductIndexToRates < ActiveRecord::Migration[5.2]
  def change
    add_index :rates, %i[user_id product_id]
  end
end
