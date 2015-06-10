# == Schema Information
#
# Table name: lines
#
#  id          :integer          not null, primary key
#  description :text
#  quantity    :integer
#  unit_price  :decimal(, )
#  vat         :decimal(, )
#  invoice_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  costs       :decimal(, )
#

require 'rails_helper'

RSpec.describe Line, type: :model do

  let(:line){create(:line, :with_costs)}

  it 'computes profit' do
    expect(line.unit_profit).to eq 300
  end

  it 'computes amount_without_tax' do
    expect(line.unit_amount_without_tax).to eq 600
  end

  it 'computes positive/negative balance?' do
    expect(line.positive_balance?).to eq true
    expect(line.negative_balance?).to eq false
    line.unit_price = 100
    expect(line.positive_balance?).to eq false
    expect(line.negative_balance?).to eq true
  end

  it 'computes other values' do
    expect(line.unit_amount_with_tax).to eq 690
    expect(line.unit_tax_amount).to eq 90
  end

  it 'computes total values' do
    line.quantity = 2
    expect(line.total_profit).to eq 600
    expect(line.total_amount).to eq 1380
  end

end
