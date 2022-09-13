module Types
  include Dry.Types()

  Relation = Types::Instance(ActiveRecord::Relation) | Types::Instance(ActiveRecord::AssociationRelation)
end
