module Types
  T.unsafe(self).include Dry.Types()

  Relation = Types::Instance(ActiveRecord::Relation) | Types::Instance(ActiveRecord::AssociationRelation)
end
