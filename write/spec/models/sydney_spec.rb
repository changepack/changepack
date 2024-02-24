# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sydney, :vcr do
  let(:account) { create(:account) }

  around do |example|
    ClimateControl.modify OPENAI_ACCESS_TOKEN: 'test' do
      example.run
    end
  end

  context 'with multiple updates' do
    subject(:sydney) { described_class.new(update: Update.all) }

    before { create_list(:update, 2, :commit, account:) }

    describe '#write' do
      subject(:result) { sydney.write }

      specify { expect(result).to be_a(String) }
    end

    describe '#choose' do
      subject(:result) { sydney.choose }

      specify { expect(result).to be_a(String) }
    end
  end

  context 'with a single update' do
    subject(:sydney) { described_class.new(update:) }

    let(:update) { create(:update, :issue, account:) }

    before { update.issue.update!(description: 'Go to [settings](https://linear.app/settings) to enable features such as Roadmap, explore features and add integrations. Use `G` then `S` to get there. ![image.png](https://uploads.linear.app/fe63b3e2-bf87-46c0-8784-cd7d639287c8/558fcd30-245d-4ddf-b15b-d9f18b1f4626/image.png) Visit individual [team settings](https://linear.app/settings/teams/) to customize features on a team level. * Configure automated issue workflows for issues linked to PRs * Add or edit *workflow statuses*, and *labels* * Add team Slack notifications * Create reusable *templates*. Use the keyboard shortcut `Alt` `C` to quickly create new issues from templates * Set your *estimate* scale and enable *cycles* * Configure time-saving features such as *Auto-close* and *Auto-archive* ![image.png](https://uploads.linear.app/fe63b3e2-bf87-46c0-8784-cd7d639287c8/9fc1632b-893e-422c-939f-0cdc9d009b37/image.png)') } # rubocop:disable Layout/LineLength

    describe '#description' do
      subject(:result) { sydney.description }

      specify { expect(result).to be_a(String) }
    end
  end
end
