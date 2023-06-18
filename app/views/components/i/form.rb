# typed: false
# frozen_string_literal: true

module I
  class Form < ApplicationComponent
    include Phlex::DeferredRender

    attribute :form, T.untyped

    def actions(&block)
      @actions = block
    end

    def form(&block)
      @form = block
    end

    def template
      top
      page
    end

    def top
      return unless top?

      top_container do
        div do
          previous_page
          page_name
        end

        div(&@actions) if @actions.present?
      end
    end

    def page
      div class: 'container mx-auto my-16 px-80 fields', &@form
    end

    def top_container(&)
      div class: 'w-full px-2 bg-white shadow-sm' do
        div class: 'relative overflow-hidden' do
          div class: 'flex-row items-center justify-between p-4 space-y-3 sm:flex sm:space-y-0 sm:space-x-4', &
        end
      end
    end

    def previous_page
      return if helpers.content_for?(:previous_page).blank?

      a class: 'font-bold inline-block mr-6 text-xl leading-none', href: helpers.content_for(:previous_page) do
        '×'
      end
    end

    def page_name
      return if helpers.content_for?(:page_name).blank?

      span class: 'dimmed' do
        helpers.content_for(:page_name)
      end
    end

    def actions? = @actions.present?

    def top?
      helpers.content_for?(:page_name) || helpers.content_for?(:previous_page) || actions?
    end
  end
end
