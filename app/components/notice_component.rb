# frozen_string_literal: true

class NoticeComponent < ViewComponent::Base
  def call
    content_tag(:p, class: 'py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block', id: 'notice') do
      content
    end
  end

  private

  def render?
    content.present?
  end
end
