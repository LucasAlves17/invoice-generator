require "rails_helper"

RSpec.describe Api::InvoicesController, type: :routing do
  describe "routing" do
    it { should route(:get, "api/invoices").to(action: :index, format: :json) }
    it { should route(:get, "api/invoices/1").to(action: :show, id: 1, format: :json) }
    it { should route(:post, "api/invoices").to(action: :create, format: :json) }
    it { should route(:put, "api/invoices/1").to(action: :update, id: 1, format: :json) }
  end
end
