# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  extend T::Sig

  include Inquirer
  include Identifier
  include Timestamp

  include Discard::Model

  self.discard_column = :discarded

  primary_abstract_class
  has_paper_trail
end
