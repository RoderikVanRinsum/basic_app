require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  describe "Validations" do
    subject { FactoryGirl.build(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value("valid@valid.valid").for(:email) }
    %w[invalid invalid.invalid **@invalid.invalid].each do |email|
      it { is_expected.not_to allow_value(email).for(:email) }
    end

    it { is_expected.to validate_length_of(:password).is_at_least(8) }
  end

  it "saves user email as lowercase" do
    user = FactoryGirl.create(:user, email: "VALID@valid.valid")
    expect(user.email).to eq("valid@valid.valid")
  end
end
