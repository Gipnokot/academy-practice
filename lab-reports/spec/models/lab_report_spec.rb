require 'rails_helper'

RSpec.describe LabReport, type: :model do
  let(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.build(:lab_report, user: user) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_length_of(:description).is_at_most(500) }

  it "validates inclusion of grade in predefined values" do
    valid_grades = %w[A B C D E FX F]
    invalid_grade = "Z"

    valid_grades.each do |grade|
      subject.grade = grade
      expect(subject).to be_valid
    end

    subject.grade = invalid_grade
    expect(subject).to be_invalid
    expect(subject.errors[:grade]).to include("is not included in the list")
  end
end
