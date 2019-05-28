class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.integer :units, default: 0, null: false
      t.string :unit_of_measure
      t.string :image
      t.references :product
    end
  end
end
