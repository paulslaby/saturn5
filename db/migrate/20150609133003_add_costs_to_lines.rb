class AddCostsToLines < ActiveRecord::Migration
  def change
    add_column :lines, :costs, :decimal
  end
end
