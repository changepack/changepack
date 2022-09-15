# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `slim-rails` gem.
# Please instead update this file by running `bin/tapioca gem slim-rails`.

# Fake filters for Slim
#
# source://slim-rails//lib/slim-rails/version.rb#1
module Slim; end

# source://slim-rails//lib/slim-rails/version.rb#2
module Slim::Rails; end

# source://slim-rails//lib/slim-rails.rb#8
class Slim::Rails::Railtie < ::Rails::Railtie; end

# source://slim-rails//lib/slim-rails/register_engine.rb#3
module Slim::Rails::RegisterEngine
  class << self
    # source://slim-rails//lib/slim-rails/register_engine.rb#12
    def register_engine(app, config); end

    private

    # source://slim-rails//lib/slim-rails/register_engine.rb#29
    def _register_engine(config); end

    # source://slim-rails//lib/slim-rails/register_engine.rb#22
    def _register_engine3(app); end
  end
end

# source://slim-rails//lib/slim-rails/register_engine.rb#4
class Slim::Rails::RegisterEngine::Transformer
  class << self
    # source://slim-rails//lib/slim-rails/register_engine.rb#5
    def call(input); end
  end
end

# source://slim-rails//lib/slim-rails/version.rb#3
Slim::Rails::VERSION = T.let(T.unsafe(nil), String)

# source://slim/4.1.0/lib/slim/version.rb#4
Slim::VERSION = T.let(T.unsafe(nil), String)
