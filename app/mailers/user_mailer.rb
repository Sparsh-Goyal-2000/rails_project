class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.created.subject
  #
  def created(user)
    @user = user

    mail to: user.email, subject: 'Welcome', body: 'Welcome'
  end
end