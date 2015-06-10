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
end
