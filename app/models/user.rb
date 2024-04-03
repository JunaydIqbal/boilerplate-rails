# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable, :trackable

  USERS_TYPES = %w(Users::SuperAdmin Users::Admin Users::Assessor Users::Client)

  validates_inclusion_of :type, in: USERS_TYPES
  enum invitation_status: %i[pending accepted declined]

  has_one_attached :profile_picture

  default_scope { order(created_at: :desc) }
  scope :active, -> { where(deleted: false, revoke_access: false) }

  USERS_TYPES.each do |type|
    define_method("#{type.demodulize.downcase}?") do
      self.type == type
    end
  end

  def self.search(query)
    if query.present?
      where("
        email ILIKE? OR first_name ILIKE? OR last_name ILIKE? OR phone_no ILIKE?", 
        "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
      ).limit(10)
    else
      all
    end
  end

  # Override devise notification system to send emails through queue backend
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
