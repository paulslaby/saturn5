class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO: refactor - make Agenda an associated model

  has_many :invoices, dependent: :destroy

  def ready_to_api_call?
    billapp_agenda.present? and billapp_login.present? and billapp_password.present?
  end
end
