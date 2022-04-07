# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { 'Account' }
  end

  factory :user do
    account
    email { 'user@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :changelog do
    user
    title { 'Title' }
    content { 'Content' }
  end
end
