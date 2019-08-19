FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'admin' }
    name { Faker::Name.name }
    trait :doctor do
      role { 'doctor' }
    end

    trait :patient do
      role { 'patient' }
    end
  end
end
