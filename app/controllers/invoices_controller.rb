class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show]
  authorize_resource

  # GET /invoices
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  def show
  end

  def synchronize
    @invoices = Invoice.for_user_id(current_user.try(:id))

    remote_ids = @invoices.map &:remote_id

    Invoice.transaction do
      begin
        @invoices.map(&:update_from_billapp)

        @new_invoices = Invoice.new_invoices_from_billapp(current_user, ignore_ids: remote_ids)
        @new_invoices.map &:save!

        redirect_to invoices_path, notice: 'Invoices successfully synchronized.'
      rescue StandardError => e
        Rails.logger.error 'sync failed'
        Rails.logger.error e
        redirect_to invoices_path, notice: 'Error appeared during sync.'
        raise ActiveRecord::Rollback
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_params
      params.require(:invoice).permit(:number, :due_date, :issue_date, :paid_on, :notes, :status, :tax_amount, :total_amount, :created_date, :updated_date, :currency_code, :currency_name)
    end
end
