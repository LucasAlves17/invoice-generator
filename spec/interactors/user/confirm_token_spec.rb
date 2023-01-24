require "rails_helper"

RSpec.describe Users::ConfirmToken do
  let(:user_to_confirm) { create :user_to_confirm}
  let(:user) { double(:user) }

  describe ".call" do
    context "when given valid token" do
      subject(:context) { Users::ConfirmToken.call(token_to_confirm: user_to_confirm[:token_to_confirm]) }

      before do
        allow(User).to receive(:find_by).with(token_to_confirm: user_to_confirm[:token_to_confirm]).and_return(user)
        allow(user).to receive(:update).and_return(user)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the user" do
        expect(context.user).to eq(user)
      end
    end

    context "when given invalid token" do
      subject(:context) { Users::ConfirmToken.call(token_to_confirm: "123") }

      before do
        allow(User).to receive(:find_by).with(token_to_confirm: "123").and_return(nil)
        allow(user).to receive(:update).and_return(user)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end