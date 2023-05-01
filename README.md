![CI](https://github.com/changepack/changepack/actions/workflows/ci.yml/badge.svg)

Changepack is an open-source changelog for your product. Share updates about new features with your customers and keep people in the loop!

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
<a href="https://render.com/deploy?repo=https://github.com/changepack/changepack">
  <img src="https://render.com/images/deploy-to-render-button.svg" alt="Deploy to Render" height="32">
</a>
<!-- HTML is required to rescale the image so that the button isn’t bigger than Heroku’s -->

## Features

* **Pull commits from GitHub**. Changepack allows you to link changelogs with your GitHub activity, making it easy to track progress.
* **Write release notes 10x faster with AI.** Leverage OpenAI’s [ChatGPT](https://openai.com/blog/chatgpt) to write your content in seconds.
* **Monthly automated summaries.** Each month, Changepack handpicks the most notable updates and creates a release note draft for you to review and publish.
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
