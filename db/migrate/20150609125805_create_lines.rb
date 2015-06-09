class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.text :description
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :vat
      t.references :invoice, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_column :invoices, :lines_count, :integer
  end
end
