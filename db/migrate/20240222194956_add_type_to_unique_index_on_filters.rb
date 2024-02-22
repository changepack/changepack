class AddTypeToUniqueIndexOnFilters < ActiveRecord::Migration[7.1]
  def change
    remove_index :filters, name: 'index_filters_on_source_id_and_trait_and_content'
    add_index :filters, [:source_id, :trait, :content, :type], name: 'index_filters_on_source_id_trait_content_and_type', unique: true
  end
end
