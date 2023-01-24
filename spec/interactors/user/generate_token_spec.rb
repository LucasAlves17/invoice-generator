require "rails_helper"

RSpec.describe Users::Create do
  let(:email) { Faker::Internet.email }
  let(:user) { double(:user) }
  let(:result) { double(:result, user: user) }

  describe ".call" do
    context "when given valid email" do
      subject(:context) { Users::GenerateToken.call(email: email) }
     
      before do
        allow(User).to receive(:find_by).with(email: email).and_return(nil)
        allow(Users::Create).to receive(:call).with(email: email).and_return(result)
        allow(user).to receive(:update).and_return(user)
        allow_any_instance_of(UserMailer).to receive(:confirmation_token).with(user)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end
    end

    context "when given invalid email" do
      subject(:context) { Users::GenerateToken.call(email: nil) }

      before do
        allow(nil).to receive(:blank?).and_return(true)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end