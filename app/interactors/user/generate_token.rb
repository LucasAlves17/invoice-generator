class User::GenerateToken
  include Interactor

  def call
    validate_email
    find_user
    create_user if context.user.nil?
    generate_token
    send_email
  end

  private

  def validate_email
    return unless context.email.nil?
    context.fail!(errors: 'Email is missing')
  end

  def find_user
    context.user = User.find_by(email: context.email)
  end

  def create_user
    result = User::Create.call(email: context.email)
    context.user = result.user
  end

  def generate_token
    context.user.update(token_to_confirm: SecureRandom.hex)
  end

  def send_email
    UserMailer.confirmation_token(context.user).deliver_now!
  end
end