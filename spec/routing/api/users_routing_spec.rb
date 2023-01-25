require "rails_helper"

RSpec.describe Api::UsersController, type: :routing do
  describe "routing" do
    it { should route(:post, "api/users").to(action: :create, format: :json) }
    it { should route(:get, "api/users/confirm").to(action: :confirm, format: :json) }
    it { should route(:post, "api/users/login").to(action: :login, format: :json) }
  end
end
