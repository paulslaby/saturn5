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

FactoryGirl.define do
  factory :line do
    description "MyText"
    quantity "1.0"
    unit_price "600"
    vat "15"
    invoice

    trait :with_costs do
      costs '300'
    end
  end

end
