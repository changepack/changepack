# typed: false
# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  extend T::Sig

  include Inquirer
  include Identifier

  include Discard::Model

  self.discard_column = :discarded_at
  self.inheritance_column = :_sti

  primary_abstract_class
  has_paper_trail

  def self.scope(name, block, sig: T.proc)
    super(name, T.let(block, sig.returns(ActiveRecord::Relation)))
  end

  sig { params(event: Event).returns(String) }
  def pub(event)
    Event.publish(event)
  end
end
