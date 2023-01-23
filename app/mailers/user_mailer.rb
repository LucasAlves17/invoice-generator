class UserMailer < ApplicationMailer
  def confirmation_token(user)
    @user = user
    @token = user.token_to_confirm
    @confirmation_link = "#{api_confirm_users_url}?token=#{@token}"
    mail(to: @user.email, subject: "Account confirmation")
  end
end
