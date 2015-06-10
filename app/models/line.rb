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

class Line < ActiveRecord::Base
  belongs_to :invoice, counter_cache: true

  before_validation {self.costs ||= 0}

  validates :description, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :vat, presence: true, numericality: true
  validates :invoice, presence: true

  validates :costs, numericality: true




  def profit
    total_amount_without_tax - costs
  end

  def total_amount_without_tax
    unit_amount_without_tax*quantity
  end

  def total_amount
    unit_amount_with_tax*quantity
  end

  def total_profit
    unit_profit*quantity
  end

  def unit_tax_amount
    unit_price * vat/100
  end

  def unit_amount_without_tax
    unit_price
  end

  def unit_amount_with_tax
    unit_price + unit_tax_amount
  end

  def unit_profit
    unit_amount_without_tax - (costs||0)
  end

  def positive_balance?
    profit > 0
  end

  def negative_balance?
    profit < 0
  end

  def from_billapp_json json
    %w(description quantity unit_price vat).each do
    |attr|
      self.send("#{attr}=", json[attr])
    end
  end
end
