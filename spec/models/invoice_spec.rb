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
  let(:invoice){create(:invoice)}
  it 'computes profit' do
    # invoice.
  end

end
