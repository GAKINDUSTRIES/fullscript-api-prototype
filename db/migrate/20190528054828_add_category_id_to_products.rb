class AddCategoryIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category
  end
end
