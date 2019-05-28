class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false, unique: true
      t.integer :status, default: 0, null: false
      t.references :brand
    end
  end
end
