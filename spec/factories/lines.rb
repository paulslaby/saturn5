FactoryGirl.define do
  factory :line do
    description "MyText"
    quantity "1.0"
    unit_price "9.99"
    vat "9.99"
    invoice
  end

end
