# typed: false
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :api_key, class: 'API::Key' do
    association :bearer, factory: :account
  end

  factory :forbidden do
    association :source, :repository
    content { Faker::Internet.email }
    type { 'email' }
  end

  factory :issue do
    title { Faker::Lorem.sentence }
    assignee { { name: Faker::Name.name, email: Faker::Internet.email } }
    team
    account { team.account }
    issued_at { Faker::Date.in_date_period }
    providers { { 'linear' => SecureRandom.uuid } }
  end

  factory :team do
    account { create(:account) }
    name { Faker::App.name }
    providers { { 'linear' => SecureRandom.uuid } }
  end

  factory :source do
    name { Faker::Lorem.sentence }

    trait :repository do
      type { 'repository' }
      account { repository.account }
      repository
      changelog { create(:changelog, account: repository.account) }
    end

    trait :team do
      type { 'team' }
      account { team.account }
      team
      changelog { create(:changelog, account: team.account) }
    end
  end

  factory :update do
    name { Faker::Lorem.sentence }
    tags { [Faker::Internet.email] }

    trait :commit do
      type { 'commit' }
      account { commit.account }
      source { create(:source, :repository, repository: commit.repository) }
      changelog { create(:changelog, account: commit.account) }
      commit
    end

    trait :issue do
      type { 'issue' }
      account { issue.account }
      source { create(:source, :team, team: issue.team) }
      changelog { create(:changelog, account: issue.account) }
      issue
    end
  end

  factory :access_token do
    token { 'access_token' }
    account { user.account }
    user

    trait :github do
      type { 'github' }
    end

    trait :linear do
      type { 'linear' }
    end
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

    trait :github do
      providers { { github: 1 } }

      after(:create) do |user|
        create(:access_token, :github, account: user.account, user:)
      end
    end

    trait :linear do
      providers { { github: 1 } }

      after(:create) do |user|
        create(:access_token, :linear, account: user.account, user:)
      end
    end
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
