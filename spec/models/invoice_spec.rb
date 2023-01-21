require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:charge_for) }
    it { should validate_presence_of(:total_in_cents) }
    it { should validate_presence_of(:emails) }
  end
end