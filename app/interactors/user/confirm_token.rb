class User::ConfirmToken
  include Interactor

  def call
    validate_token
    confirm_token
  end

  private

  def validate_token
    return unless context.token_to_confirm.nil?
    context.fail!(errors: 'Token is missing')
  end

  def confirm_token
    context.user = User.find_by(token_to_confirm: context.token_to_confirm)
    context.fail!(errors: 'Invalid token') if context.user.nil? 
    context.user.update(token: context.token_to_confirm, token_to_confirm: nil)   
  end
end