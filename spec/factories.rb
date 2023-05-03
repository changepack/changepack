# typed: false
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :issue do
    title { Faker::Lorem.sentence }
    assignee { { name: Faker::Name.name } }
    team
    account { team.account }
    providers { { 'linear' => SecureRandom.uuid } }
  end

  factory :team do
    account { create(:account) }
    name { Faker::App.name }
    providers { { 'linear' => SecureRandom.uuid } }
  end

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
    providers { { 'github' => SecureRandom.uuid } }
  end

  factory :repository do
    account { create(:account) }
    name { "#{Faker::App.name.downcase}/#{Faker::App.name.downcase}" }
    branch { 'main' }
    providers { { 'github' => SecureRandom.uuid } }
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
