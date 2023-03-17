# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Inquirer
  include Identifier

  include Discard::Model

  self.discard_column = :discarded_at

  primary_abstract_class
  has_paper_trail
end
