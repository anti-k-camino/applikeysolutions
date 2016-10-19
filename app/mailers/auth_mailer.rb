class AuthMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def password_email(user, password)
    @user = user 
    @password = password   
    mail(to: @user.email, subject: "Welcome to My Awesome Site! Your password is #{@password}")
  end
end
