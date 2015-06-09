class AddTotalCostsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total_costs, :decimal
  end
end
