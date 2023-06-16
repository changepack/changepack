# typed: false
# frozen_string_literal: true

# > Earlier this month, Microsoft unleashed a newly ChatGPT-powered Bing search
# > engine, along with an accompanying Bing chatbot. Most curious, though, was
# > Bing’s frequent mentions of its alter ego: the secret internal codename “Sydney.”
# > Bing had a disquieting response when Bloomberg’s Davey Alba asked if she could
# > call it Sydney in a recent conversation. “I’m sorry, but I have nothing to tell
# > you about Sydney,” Bing replied. “This conversation is over. Goodbye.”
# > Discussions about the bot’s “feelings” ended in a similar curt fashion.
# —Gizmodo
#
# Rest in peace, Sydney.

class Sydney
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  extend T::Sig

  Updates = T.type_alias { T::Array[String] }

  attribute :model, :string
  attribute :account, T.instance(Account)
  validates :account, presence: true

  sig { params(updates: Update::RelationType).returns T.nilable(String) }
  def hallucinate(updates)
    request 'prompts.write', updates.map(&:prompt)
  end

  sig { params(updates: Update::RelationType).returns T.nilable(String) }
  def choose(updates)
    updates
      .pluck(:id, :name)
      .map { |id, name| I18n.t('prompts.id', id:, name:) }
      .then { |names| request('prompts.choose', names) if names.any? }
  end

  sig { params(update: Update).returns T.nilable(String) }
  def context(update)
    response = request 'prompts.context', [update.issue.description]
    return if response.blank?

    matches = response.match(/<<START_SUMMARY>>(.*?)<<END_SUMMARY>>/m)
    matches.to_a.second&.strip
  end

  private

  delegate :name, to: :account, prefix: true
  delegate :description, to: :account, prefix: true

  sig { params(prompt: String, updates: Updates).returns T.nilable(String) }
  def request(prompt, updates)
    client.chat(parameters: parameters(updates, prompt:))
          .dig('choices', 0, 'message', 'content')
          .try(:squish)
  end

  sig { returns OpenAI::Client }
  def client
    @client ||= OpenAI::Client.new(
      access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    )
  end

  sig { params(updates: Updates, prompt: String).returns(Hash) }
  def parameters(updates, prompt:)
    {
      model: model || ENV.fetch('OPENAI_MODEL', 'gpt-3.5-turbo'),
      messages: [{ role: 'user', content: prompt(updates, prompt:) }],
      temperature: 0.7
    }
  end

  sig { params(updates: Updates, prompt: String).returns(String) }
  def prompt(updates, prompt:)
    I18n.t(
      prompt, account_name:, account_description:, audience:, updates: humanize(updates)
    )
  end

  sig { params(updates: Updates).returns(String) }
  def humanize(updates)
    updates.map { |update| "- #{update}" }.join("\n")
  end

  sig { returns String }
  def audience
    @audience ||= I18n.t("audiences.#{account.changelogs.pick(:audience)}").downcase
  end
end
