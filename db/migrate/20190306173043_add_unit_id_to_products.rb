class AddUnitIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :unit, foreign_key: true
  end
end
