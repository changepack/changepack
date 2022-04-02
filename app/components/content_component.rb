# frozen_string_literal: true

class ContentComponent < ViewComponent::Base
  renders_one :article
  renders_one :metadata
end
