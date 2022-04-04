# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :user do
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
