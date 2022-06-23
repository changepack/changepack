module Types
  include Dry.Types()

  EventId = Types::Coercible::String.default { SecureRandom.uuid }
  Metadata = Types.Constructor(RubyEventStore::Metadata) { |value| RubyEventStore::Metadata.new(value.to_h) }.default { RubyEventStore::Metadata.new }
  Relation = Types::Instance(ActiveRecord::Relation) | Types::Instance(ActiveRecord::AssociationRelation)
end
