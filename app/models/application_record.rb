# typed: false
# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include ActiveModel::T

  include Inquirer
  include Identifier

  include Discard::Model

  self.discard_column = :discarded_at

  primary_abstract_class
  has_paper_trail

  def self.typed_scope(name, block, sig:)
    scope(name, T.let(block, sig)) # rubocop:disable Rails/ScopeArgs
  end
end
