![CI](https://github.com/changepack/changepack/actions/workflows/ci.yml/badge.svg)

Changepack is an open-source changelog for your product. Share updates about your product with your customers and keep people in the loop!

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

# Features

* **Pull commits from GitHub**. Changepack allows you to link changelogs with your GitHub activity, making it easy to track progress.
* **Write release notes faster and more easily with AI.** For boring updates, we use OpenAI’s [GPT-3](https://en.wikipedia.org/wiki/GPT-3) to help you write new changelogs without actually typing anything!

# Build and run locally

```
git clone https://github.com/changepack/changepack.git
cd changepack

# Install dependencies
bundle install
yarn install

# Update environment variables
cp config/application.yml.example config/application.yml

# Run application
bundle exec rails db:create db:migrate db:seed
bundle exec rails s
```

Use `tmuxinator` or `foreman` to run backgrounds processes like `guard`, a `cypruss` server, or a `tailwindcss` watcher.
