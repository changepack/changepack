account = Account.create!(name: 'Changepack')
user = User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password', account: account)
