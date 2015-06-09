class AddIndexOnBillappIdToInvoices < ActiveRecord::Migration
  def change
    add_index :invoices, :remote_id
  end
end
