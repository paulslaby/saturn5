FactoryGirl.define do
  factory :invoice do
    number "MyString"
due_date "2015-06-09"
issue_date "2015-06-09"
paid_on "2015-06-09"
notes "MyText"
status "draft"
tax_amount "9.99"
total_amount "9.99"
created_date "2015-06-09 12:07:10"
updated_date "2015-06-09 12:07:10"
currency_code "CZK"
    remote_id 1
    user
  end

end
