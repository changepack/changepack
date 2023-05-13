if defined?(Bullet)
  Bullet.add_safelist(
    type: :unused_eager_loading,
    class_name: 'ActionText::RichText',
    association: :embeds_attachments
  )

  Bullet.add_safelist(
    type: :unused_eager_loading,
    class_name: 'ActiveStorage::Attachment',
    association: :blob
  )

  Bullet.add_safelist(
    type: :unused_eager_loading,
    class_name: 'Update',
    association: :issue
  )

  Bullet.add_safelist(
    type: :unused_eager_loading,
    class_name: 'Update',
    association: :commit
  )

  Bullet.add_safelist(
    type: :unused_eager_loading,
    class_name: 'Source',
    association: :repository
  )

  Bullet.add_safelist(
    type: :unused_eager_loading,
    class_name: 'Source',
    association: :team
  )
end
