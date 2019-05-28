class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name, null: false, unique: true
      t.integer :status, default: 0, null: false
      t.integer :prefix, null: false
    end
  end
end
