class User::ConfirmToken
  include Interactor

  def call
    context.user = User.find_by(token_to_confirm: context.token_to_confirm)
    context.fail! if context.user.nil? 
    context.user.update(token: context.token_to_confirm, token_to_confirm: nil)
  end
end