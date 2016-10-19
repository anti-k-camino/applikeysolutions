class User < ApplicationRecord  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  include Authorizations 

  validates :name, :email, :password, presence: true
  validates :name, uniqueness: { case_sensitive: false }  

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
