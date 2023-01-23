require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'email@teste.com') }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
