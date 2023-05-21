# typed: false
# frozen_string_literal: true

module I
  class Logotype < ApplicationComponent
    class Brand < T::Struct
      attribute :name, String
      attribute :website, String
      attribute :picture, String

      def self.default(website)
        Brand.new(name: ENV.fetch('APP_NAME'), picture: 'logo.png', website:)
      end

      def merge(other)
        Brand.new(**serialize.merge(other.serialize.compact).deep_symbolize_keys)
      end
    end

    attribute :brand, T.nilable(T::Struct)

    def template
      a class: 'flex-shrink-0 flex items-center', href: changepack.website do
        img src: helpers.image_path(changepack.picture), class: 'inline h-7 w-7 rounded-full mr-2'
        span class: 'hover:text-gray-800 text-lg font-semibold' do
          plain changepack.name
        end
      end
    end

    def changepack
      @changepack ||= Brand.default(root_url).merge(brand)
    end
  end
end
