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

  Input = T.type_alias { T::Array[String] }
  Output = T.type_alias { T.nilable(String) }

  attribute :model, :string
  attribute :update, T.instance(T.type_alias { T.any(Update, Update::RelationType) })

  validates :update, presence: true

  sig { returns Output }
  def write
    return if invalid?

    input = humanize updates.map(&:prompt)
    content = prompt(:write, input)
    request(content)
  end

  sig { returns Output }
  def choose
    return if invalid?

    input = humanize updates.map { |upd| upd.prompt(true) }
    content = prompt(:choose, input)
    request(content)
  end

  sig { returns Output }
  def description
    return if invalid?

    content = prompt(:description, update.issue.description)
    response = request(content)
    return if response.blank?

    matches = response.match(/<<START_SUMMARY>>(.*?)<<END_SUMMARY>>/m)
    matches.to_a.second&.strip
  end

  private

  delegate :account, to: :newsletter
  delegate :name, to: :account, prefix: true
  delegate :description, to: :account, prefix: true

  alias updates update

  sig { params(content: String).returns Output }
  def request(content)
    client.chat(parameters: parameters(content))
          .dig('choices', 0, 'message', 'content')&.squish
  end

  sig { returns OpenAI::Client }
  def client
    @client ||= OpenAI::Client.new(
      access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    )
  end

  sig { params(content: String).returns(Hash) }
  def parameters(content)
    {
      model: model || ENV.fetch('OPENAI_MODEL', 'gpt-3.5-turbo'),
      messages: [{ role: 'user', content: }],
      temperature: 0.7
    }
  end

  sig { params(prompt: T::Key, input: String).returns(String) }
  def prompt(prompt, input)
    I18n.t(
      "prompts.#{prompt}", account_name:, account_description:, audience:, updates: input
    )
  end

  sig { params(updates: Input).returns(String) }
  def humanize(updates)
    updates.map { |update| "- #{update}" }.join("\n")
  end

  sig { returns T.nilable(String) }
  def audience
    @audience ||= newsletter.audience&.downcase
  end

  sig { returns Newsletter }
  def newsletter
    @newsletter ||= update.is_a?(Update) ? update.newsletter : updates.first.newsletter
  end
end
