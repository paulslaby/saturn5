# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  billapp_login          :string
#  billapp_password       :string
#  billapp_agenda         :string
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "joe#{n}@example.com" }
    password         'joesthebest'

    #trait :with_billapp_credentials do
      billapp_login 'paul.slaby@seznam.cz'
      billapp_password 'asdfgh'
      billapp_agenda 'kanibal'
    #end
  end
end
