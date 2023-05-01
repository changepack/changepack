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

  extend T::Sig

  attribute :account, T.instance(Account)

  Updates = T.type_alias { T::Array[String] }

  sig { params(updates: Updates).returns(String) }
  def hallucinate(updates)
    client.chat(parameters: parameters(updates))
          .dig('choices', 0, 'message', 'content')
          .strip
  end

  private

  delegate :name, to: :account, prefix: true
  delegate :description, to: :account, prefix: true

  sig { returns OpenAI::Client }
  def client
    @client ||= OpenAI::Client.new
  end

  sig { params(updates: Updates).returns(Hash) }
  def parameters(updates)
    {
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'user', content: prompt(updates) }],
      temperature: 0.7
    }
  end

  sig { params(updates: Updates).returns(String) }
  def prompt(updates)
    I18n.t(
      'prompt', account_name:, account_description:, updates: updates.join("\n")
    )
  end
end
