# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
  end

  factory :user do
    account
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end

  factory :changelog do
    user
    account { user.account }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
