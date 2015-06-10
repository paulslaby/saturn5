require 'rspec'

describe 'invoices/index', :type => :view do

  let(:invoice) { create(:invoice) }
  let(:user) { invoice.user }
  before do
    view.stub(:current_user) { invoice.user }
    allow(view).to receive_messages(:will_paginate => nil)
  end

  it 'should correctly display views' do
    invoice.save
    assign(:invoices, Invoice.all)
    render
    expect(rendered).to include(invoice.number.to_s)
  end
end


describe 'invoices/show', :type => :view do

  let(:invoice) { create(:invoice) }
  let(:user) { invoice.user }
  before do
    view.stub(:current_user) { invoice.user }
    allow(view).to receive_messages(:will_paginate => nil)
  end

  it 'should correctly display views' do
    assign(:invoice, invoice)
    render
    expect(rendered).to include(invoice.number.to_s)
  end
end