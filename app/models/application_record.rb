# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Inquirer
  include PrettyId

  primary_abstract_class

  class << self
    def key(id)
      self.id_prefix = id
      self.id_separator = '_'
    end
  end
end
