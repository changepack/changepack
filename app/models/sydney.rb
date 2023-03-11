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

  attribute :account

  def hallucinate(changes)
    client.chat(parameters: parameters(changes))
          .dig('choices', 0, 'message', 'content')
          .strip
  end

  private

  delegate :name, to: :account, prefix: true
  delegate :description, to: :account, prefix: true

  def client
    @client ||= OpenAI::Client.new
  end

  def parameters(changes)
    {
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'user', content: prompt(changes) }],
      temperature: 0.7
    }
  end

  def prompt(changes)
    I18n.t(
      'prompt', account_name:, account_description:, changes: changes.join("\n")
    )
  end
end
