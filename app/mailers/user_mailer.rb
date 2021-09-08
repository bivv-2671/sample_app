class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email.activate")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("email.pass_reset")
  end
end
