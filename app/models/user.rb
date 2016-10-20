class User < ApplicationRecord 

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte] 

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy  

  include Authorizations 

  mount_uploader :image, ImageUploader  

  validates :name, :email, :password, presence: true
  validates :name, uniqueness: { case_sensitive: false } 

  def name
    email.split('@')[0]
  end 

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
