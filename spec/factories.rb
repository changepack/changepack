# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :commit do
    message { Faker::Lorem.sentence }
    url { Faker::Internet.url(host: 'example.com') }
    commited { Faker::Date.in_date_period }
    author { { name: Faker::Name.name, email: Faker::Internet.email } }
    repository
    account { repository.account }
  end

  factory :repository do
    user
    account { user.account }
    name { "#{Faker::App.name.downcase}/#{Faker::App.name.downcase}" }
    branch { 'main' }
    provider { 'github' }
    provider_id { '1' }
  end

  factory :account do
    name { Faker::Company.name }
  end

  factory :user do
    account
    name { Faker::Name.name }
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
