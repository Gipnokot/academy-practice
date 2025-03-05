FactoryBot.define do
  factory :lab_report do
    title { "Sample Report" }
    description { "This is a test description" }
    grade { "A" }
    association :user
  end
end
