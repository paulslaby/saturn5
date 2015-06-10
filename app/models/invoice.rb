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

class Invoice < ActiveRecord::Base

  include HTTParty

  belongs_to :user
  has_many :lines, dependent: :destroy
  accepts_nested_attributes_for :lines

  before_save :cache_costs

  validates :number, presence: true, length: {in: 0..255}
  validates :remote_id, presence: true, numericality: {only_integer: true}, uniqueness: {scope: :user}
  validates :status, presence: true, length: {in: 0..255}
  validates :currency_code, presence: true, length: {in: 0..255}
  # validates :currency_name, presence: true, length: {in: 0..255}
  validates_date :due_date
  validates_date :issue_date
  validates_date :paid_on, allow_nil: true
  validates_datetime :created_date
  validates_datetime :updated_date
  validates :tax_amount, numericality: true
  validates :total_amount, numericality: true
  validates :user, presence: true

  scope :for_user_id, ->(user_id){where(user_id: user_id)}
  default_scope { order('created_date desc') }

  def roi
    return 0 if total_costs.zero?
    profit/total_costs*100
  end

  def profit
    amount_without_tax - total_costs
  end

  def amount_without_tax
    total_amount - tax_amount
  end

  def positive_balance?
    profit > 0
  end

  def negative_balance?
    profit < 0
  end

  def update_from_billapp!
    login, pass, agenda = self.user.billapp_login, self.user.billapp_password, self.user.billapp_agenda

    auth = {:username => login, :password => pass}
    response = HTTParty.get("http://#{agenda}.billapp.cz/invoices/#{id}.json",
                         :basic_auth => auth)

    if response.code != 200 # not OK response
      self.destroy if response.code == 404 # deleted invoice
      return nil
    end

    json = JSON.parse response.body

    self.from_billapp_json json

    self.save!
  end

  def from_billapp_json json
    %w(number status due_date issue_date paid_on notes tax_amount total_amount).each do
    |attr|
      self.send("#{attr}=", json[attr])
    end
    self.currency_code = json['currency']
    # renamed attributes
    self.created_date = json['created_at']
    self.updated_date = json['updated_at']
    self.remote_id = json['id']

    if self.updated_date_changed?
      lines.destroy_all
      line = lines.new

      json['lines'].each do
        |json_line|
        line.from_billapp_json json_line
      end
    end

    self
  end

  def self.from_billapp_json json
    i = Invoice.new
    i.from_billapp_json json
    i
  end

  def self.new_invoices_from_billapp(user, options={})
    ignore_ids = options.delete(:ignore_ids) || []
    result= []

    login, pass, agenda = user.billapp_login, user.billapp_password, user.billapp_agenda

    auth = {:username => login, :password => pass}
    response = HTTParty.get("http://#{agenda}.billapp.cz/invoices.json",
                               :basic_auth => auth)

    return nil if response.code != 200

    json = JSON.parse response.body
    json.each do |invoice_json|
      next if ignore_ids.include? invoice_json['id']
      i = Invoice.from_billapp_json(invoice_json['invoice'])
      i.user = user
      result << i
    end

    result
  end

  private
  def cache_costs
    self.total_costs = lines.inject(0){|sum, l| sum + (l.costs||0) }
  end
end
