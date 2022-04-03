# typed: ignore
# frozen_string_literal: true

module Inquirer
  extend ::ActiveSupport::Concern

  module NilInquiry
    def method_missing(method_name, *args, &)
      return false if method_name.to_s.include?('?')

      super
    end

    def nil?
      true
    end

    def respond_to_missing?(method_name, include_private = false)
      return true if method_name.to_s.include?('?')

      super
    end
  end

  class_methods do
    def inquirer(*methods)
      methods.each do |method_name|
        define_method :"#{method_name}" do
          value = super()
          value.nil? ? ''.extend(NilInquiry) : value.inquiry
        end
      end
    end
  end
end
