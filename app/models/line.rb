class Line < ActiveRecord::Base
  belongs_to :invoice, counter_cache: true

  before_validation {self.costs ||= 0}

  validates :description, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :vat, presence: true, numericality: true
  validates :invoice, presence: true

  validates :costs, numericality: true


  def total_amount
    quantity*unit_price
  end
  def tax_amount
    unit_price.to_f*vat/(100+vat)
  end
  def amount_without_tax
    total_amount - tax_amount
  end

  def positive_balance?
    amount_without_tax > costs
  end
  def negative_balance?
    amount_without_tax < costs
  end

  def from_billapp_json json
    %w(description quantity unit_price vat).each do
    |attr|
      self.send("#{attr}=", json[attr])
    end
  end
end
