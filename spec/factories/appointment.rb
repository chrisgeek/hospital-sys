FactoryBot.define do
  factory :appointment do
    title { Faker::Lorem.sentence }
    association :user
    association :doctor
    association :patient
  end
end

