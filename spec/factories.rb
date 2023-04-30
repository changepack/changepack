# typed: false
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :source do
    name { Faker::Lorem.sentence }
    type { 'repository' }
    account { repository.account }
    repository
    changelog { create(:changelog, account: repository.account) }
  end

  factory :update do
    source { create(:source, repository: commit.repository) }
    name { Faker::Lorem.sentence }
    type { 'commit' }
    account { commit.account }
    commit
    changelog { create(:changelog, account: commit.account) }
  end

  factory :access_token do
    provider { 'github' }
    token { 'access_token' }
    user
    account { user.account }
  end

  factory :changelog do
    name { account.name }
    account
  end

  factory :commit do
    message { Faker::Lorem.sentence }
    url { Faker::Internet.url(host: 'example.com') }
    commited_at { Faker::Date.in_date_period }
    author { { name: Faker::Name.name, email: Faker::Internet.email } }
    repository
    account { repository.account }
    providers { { 'github' => '547f300205087e675a1badf2b148c8b361b25e15' } }
  end

  factory :repository do
    account { create(:account) }
    name { "#{Faker::App.name.downcase}/#{Faker::App.name.downcase}" }
    branch { 'main' }
    providers { { 'github' => 1 } }
  end

  factory :repository_transition do
    repository
    sort_key { (repository.transitions.count + 1) * 10 }
    to_state { 'active' }
    most_recent { false }
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

  factory :post do
    user
    account { user.account }
    changelog { build(:changelog, account:) }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end

  factory :post_transition do
    post
    sort_key { (post.transitions.count + 1) * 10 }
    to_state { 'published' }
    most_recent { false }
  end
end
