# == Schema Information
#
# Table name: invoices
#
#  id            :integer          not null, primary key
#  number        :string
#  due_date      :date
#  issue_date    :date
#  paid_on       :date
#  notes         :text
#  status        :string
#  tax_amount    :decimal(, )
#  total_amount  :decimal(, )
#  created_date  :datetime
#  updated_date  :datetime
#  currency_code :string
#  currency_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  remote_id     :integer          not null
#  lines_count   :integer
#  total_costs   :decimal(, )
#

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:invoice){create(:invoice, :with_line_with_costs)}

  it 'computes profit' do
    expect(invoice.profit).to eq 300
  end


  it 'computes ROI' do
    expect(invoice.roi).to eq 100
  end

  it 'computes amount_without_tax' do
    expect(invoice.amount_without_tax).to eq 600
  end

  it 'computes positive/negative balance?' do
    expect(invoice.positive_balance?).to eq true
    expect(invoice.negative_balance?).to eq false
    invoice.total_amount = 100
    expect(invoice.positive_balance?).to eq false
    expect(invoice.negative_balance?).to eq true
  end

  it 'caches costs' do
    invoice.lines.map{|l| l.costs *= 3}
    invoice.save!
    invoice.reload
    expect(invoice.total_costs).to eq 900
  end

end
