class TwoFactorMailer < ActionMailer::Base
  default from: 'simtekapp@gmail.com'
  def send_authentication_code(user, code)
    @user = user
    @code = code
    mail(to: @user.email, subject: 'Authentication Code')
  end
end