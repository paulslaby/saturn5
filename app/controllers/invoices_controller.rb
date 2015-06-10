class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update]
  authorize_resource

  # GET /invoices
  def index
    @invoices = Invoice.accessible_by(current_ability).paginate(page: params[:page])
  end

  # GET /invoices/1
  def show
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: 'Costs successfully updated.'
    else
      render :edit
    end
  end

  def synchronize
    @invoices = Invoice.accessible_by(current_ability).for_user_id(current_user.try(:id))

    remote_ids = @invoices.map &:remote_id

    Invoice.transaction do
      begin
        @invoices.map(&:update_from_billapp!)

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
      params.require(:invoice).permit(lines_attributes: [:id, :costs])
    end
end
