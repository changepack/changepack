# frozen_string_literal: true

class ContentComponent < LegacyApplicationComponent
  renders_one :article
  renders_one :sidebar
end
