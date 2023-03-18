# typed: false
# frozen_string_literal: true

class ContentComponent < ApplicationComponent
  include Phlex::DeferredRender

  def template
    div class: 'py-8 block md:flex md:flex-nowrap md:flex-row-reverse' do
      div class: 'md:flex-grow', &@article
      div class: 'md:w-64 mt-4 md:mt-0 md:flex-shrink-0 md:flex md:flex-col', &@sidebar
    end
  end

  def article(&block)
    @article = block
  end

  def sidebar(&block)
    @sidebar = block
  end
end
