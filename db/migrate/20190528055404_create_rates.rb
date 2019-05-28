class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.float :value, null: false
      t.references :user
      t.references :product
    end
  end
end
