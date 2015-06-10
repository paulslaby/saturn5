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

FactoryGirl.define do
  factory :invoice do
    number "MyString"
    due_date "2015-06-09"
    issue_date "2015-06-09"
    paid_on "2015-06-09"
    notes "MyText"
    status "draft"
    tax_amount "100"
    total_amount "700"
    created_date "2015-06-09 12:07:10"
    updated_date "2015-06-09 12:07:10"
    currency_code "CZK"
    remote_id 1
    user

    trait :with_line do
      lines {[FactoryGirl.create(:line)]}
    end

    trait :with_line_with_costs do
      lines {[FactoryGirl.create(:line, :with_costs)]}
    end

  end

end
