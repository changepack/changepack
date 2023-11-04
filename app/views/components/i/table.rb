# typed: false
# frozen_string_literal: true

module I
  class Table < ApplicationComponent
    include Phlex::DeferredRender

    attr_reader :headings, :cells

    def before_template
      @headings = []
      @cells = []

      super
    end

    def template
      wrapper do
        top
        content
        navigation
      end
    end

    def row(heading, &block)
      @headings << heading if headings.index(heading).blank?
      @cells << block
    end

    def wrapper(&)
      div class: 'bg-white relative shadow-sm sm:rounded-lg overflow-hidden border border-gray-100', &
    end

    def top
      div class: 'flex flex-col md:flex-row items-center justify-between space-y-3 md:space-y-0 md:space-x-4 p-4' do
        search
        actions
      end
    end

    def content
      div class: 'overflow-x-auto' do
        table class: 'w-full text-sm text-left text-gray-500' do
          thead
          tbody
        end
      end
    end

    def navigation
      nav class: navigation_classes do
        span class: 'text-sm font-normal text-gray-500' do
          plain 'Showing '
          span(class: 'font-semibold text-gray-900') { '1-10' }
          plain ' of '
          span(class: 'font-semibold text-gray-900') { '1000' }
        end
        # Add pagination here
      end
    end

    def thead
      super class: 'text-xs text-gray-700 uppercase bg-gray-50' do
        tr do
          headings.each do |heading|
            th scope: 'col', class: 'px-4 py-3' do
              heading
            end
          end
        end
      end
    end

    def tbody
      super do
        tr class: 'border-b' do
          cells.each do |cell|
            td class: 'px-4 py-3', &cell
          end
        end
      end
    end

    def search
      div class: 'w-full md:w-1/2' do
        span class: 'font-normal text-gray-500' do
          'Add, edit, or remove your changelogs'
        end
        # Replace with search later
      end
    end

    def actions
      div class: actions_classes do
        button class: 'button-1' do
          'Add changelog'
        end
        # Add other actions here
      end
    end

    def navigation_classes
      'flex flex-col md:flex-row justify-between items-start md:items-center space-y-3 md:space-y-0 p-4'
    end

    def actions_classes
      %(
        w-full md:w-auto flex flex-col md:flex-row space-y-2 md:space-y-0
        items-stretch md:items-center justify-end md:space-x-3 flex-shrink-0'
      )
    end
  end
end
