![CI](https://github.com/changepack/changepack/actions/workflows/ci.yml/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/6fcca30f3ba6843848db/maintainability)](https://codeclimate.com/github/changepack/changepack/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6fcca30f3ba6843848db/test_coverage)](https://codeclimate.com/github/changepack/changepack/test_coverage)

Every week, Changepack delivers a brief update to you or your company, highlighting the progress your team achieved in the past week, all powered by ChatGPT. It’s a great way to keep folks informed about new changes and features, ensuring everyone stays connected and up-to-date!

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
<a href="https://render.com/deploy?repo=https://github.com/changepack/changepack">
  <img src="https://render.com/images/deploy-to-render-button.svg" alt="Deploy to Render" height="32">
</a>
<!-- HTML is required to rescale the image so that the button isn’t bigger than Heroku’s -->

## Features

* **Weekly summaries.** Each week, Changepack handpicks the most notable updates and emails you a release note. We leverage OpenAI’s [ChatGPT](https://openai.com/blog/chatgpt) to publish your content in seconds.
* **Pull commits from GitHub.** You can link Changepack with your GitHub activity, making it easy to track progress. (GitLab coming soon!)
* **Retrieve issues from Linear.** We connect to project management tools of your choice, allowing ChatGPT to stay informed about your current tasks. (Other tools coming soon.)

## Use cases

* As a manager, I can receive weekly email updates on my team’s progress from GitHub, eliminating the need to constantly ask them for status updates.
* As a programmer, I can receive a summary of my work from the previous week and share it in my team’s status update channel on Slack, so everyone is informed about what I’ve shipped.

## Build and run locally

```
git clone https://github.com/changepack/changepack.git
cd changepack

# Install dependencies
bundle install
yarn install

# Update environment variables
cp config/application.yml.example config/application.yml

# Run the application
bundle exec rails db:create db:migrate db:seed
bin/test
bundle exec rails s
```

Use `tmuxinator` or `foreman` to run backgrounds processes like `guard`, a `cypruss` server, or a `tailwindcss` watcher.

## Contributors 🎉

Looking to contribute? Please refer to our [CONTRIBUTING.md](./CONTRIBUTING.md) file.
