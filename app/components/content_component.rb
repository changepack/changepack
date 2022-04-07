# frozen_string_literal: true

class ContentComponent < ApplicationComponent
  renders_one :article
  renders_one :sidebar
end
