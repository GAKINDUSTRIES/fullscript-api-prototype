class ChangePrefixTypeOnProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :brands, :prefix, :string
  end
end
