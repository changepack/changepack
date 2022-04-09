if defined?(Bullet)
  Bullet.add_safelist(type: :unused_eager_loading, class_name: 'ActionText::RichText', association: :embeds_attachments)
  Bullet.add_safelist(type: :unused_eager_loading, class_name: 'ActiveStorage::Attachment', association: :blob)
end
