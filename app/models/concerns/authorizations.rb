require 'active_support/concern'

module Authorizations
  extend ActiveSupport::Concern  

  included do
    has_many :authorizations, dependent: :destroy
    public_class_method :find_for_oauth, :create_self_and_authorization!     
  end 
  
  def create_authorization!(auth)
    transaction do
      authorizations.create!(provider: auth['provider'], uid: auth['uid'])
      update!(confirmed_at: nil)
    end    
    self.send_confirmation_instructions 
  end

  module ClassMethods

    def create_self_and_authorization!(auth, email)
      pass = Devise.friendly_token[0, 20]
      transaction do             
        @user = User.create!(name: auth['info']['name'], email: email, password: pass, password_confirmation: pass)     
        @user.authorizations.create!(provider: auth['provider'], uid: auth['uid'])
      end
    end

    def find_for_oauth(auth)
      authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
      return authorization.user if authorization

      email = auth.info.try(:email)   
      user = User.where(email: email).first
      if user
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
      elsif email
        name = auth.info[:name]
        password = Devise.friendly_token[0, 20]
        user = User.create!(name: name, email: email, password: password, password_confirmation: password, confirmed_at: Time.now)
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
        AuthMailer.password_email(user, password).deliver_now
      end
      user
    end
  end
end