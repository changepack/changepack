# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.push File.expand_path('../../spec', __dir__)
require File.expand_path('../../config/environment', __dir__)
require File.expand_path('../../spec/rails_helper', __dir__)

require_relative '../lib/changelogs'
