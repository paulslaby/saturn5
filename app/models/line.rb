class Line < ActiveRecord::Base
  belongs_to :invoice, counter_cache: true

  validates :description, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :vat, presence: true, numericality: true
  validates :invoice, presence: true

  validates :costs, presence: true, numericality: true


  def from_billapp_json json
    %w(description quantity unit_price vat).each do
    |attr|
      self.send("#{attr}=", json[attr])
    end
  end
end
