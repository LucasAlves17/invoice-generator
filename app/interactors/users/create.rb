class Users::Create
  include Interactor

  def call
    context.user = User.new(email: context.email)
    context.fail! unless context.user.save     
  end
end