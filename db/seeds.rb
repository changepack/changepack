account = Account.create!(name: ENV.fetch('APP_NAME'))
user = User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password', account: account)
