require "rails_helper"

RSpec.describe Users::Login do
  let(:user) { create :user}
  let(:token) { double(:token)}

  describe ".call" do
    context "when given valid token" do
      subject(:context) { Users::Login.call(token: user[:token]) }

      before do
        allow(token).to receive(:blank?).and_return(false)
        allow(User).to receive(:find_by).with(token: user[:token]).and_return(user)
        allow(user).to receive(:update).and_return(user)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end
    end

    context "when given invalid token" do
      subject(:context) { Users::Login.call(token: "123") }

      before do
        allow(token).to receive(:blank?).and_return(true)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end