class Users::Login
  include Interactor

  def call
    context.fail!(errors: 'Token is missing') if context.token.blank?
    context.user = User.find_by(token: context.token)
    context.fail!(errors: 'Invalid token') if context.user.nil?
  end
end