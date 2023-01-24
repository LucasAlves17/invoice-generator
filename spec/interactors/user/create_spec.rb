require "rails_helper"

RSpec.describe Users::Create do
  let(:email) { Faker::Internet.email }
  let(:user) { double(:user) }

  describe ".call" do
    context "when given valid email" do
      subject(:context) { Users::Create.call(email: email) }

      before do
        allow(User).to receive(:new).with(email: email).and_return(user)
        allow(user).to receive(:save).and_return(user)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the user" do
        expect(context.user).to eq(user)
      end
    end

    context "when given invalid email" do
      subject(:context) { Users::Create.call(email: nil) }

      before do
        allow(User).to receive(:new).with(email: nil).and_return(user)
        allow(user).to receive(:save).and_return(false)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end