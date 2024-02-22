account = Account.find_or_create_by! name: ENV.fetch('APP_NAME')

User.create_with(
  name: 'John Doe',
  password: 'password',
  password_confirmation: 'password',
  account:
).find_or_create_by!(email: 'john.doe@example.com')

Notification::Template.find_or_initialize_by(
  type: :summary,
  category: :write
).update!(
  title: 'New changelog',
  summary: 'Read your weekly changelog below.'
)
