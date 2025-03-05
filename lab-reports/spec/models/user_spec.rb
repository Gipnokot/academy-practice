require "rails_helper"

RSpec.describe User, type: :model do
  subject { described_class.create!(first_name: "John", last_name: "Doe", email: "test@example.com") }

  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name).is_at_most(100) }

  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:last_name).is_at_most(100) }

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(150) }
  it { should allow_value("valid@example.com").for(:email) }
  it { should_not allow_value("invalid-email").for(:email) }

  it { should validate_uniqueness_of(:email) }
end
