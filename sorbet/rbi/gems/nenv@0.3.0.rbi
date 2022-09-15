# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `nenv` gem.
# Please instead update this file by running `bin/tapioca gem nenv`.

# source://yard/0.9.28/lib/yard.rb#62
::RUBY19 = T.let(T.unsafe(nil), TrueClass)

# source://nenv//lib/nenv/version.rb#1
module Nenv
  class << self
    # source://nenv//lib/nenv.rb#26
    def instance; end

    # source://nenv//lib/nenv.rb#18
    def method_missing(meth, *args); end

    # source://nenv//lib/nenv.rb#22
    def reset; end

    # @return [Boolean]
    #
    # source://nenv//lib/nenv.rb#14
    def respond_to?(meth); end
  end
end

# source://nenv//lib/nenv/autoenvironment.rb#3
class Nenv::AutoEnvironment < ::Nenv::Environment
  # source://nenv//lib/nenv/autoenvironment.rb#4
  def method_missing(meth, *args); end
end

# source://nenv//lib/nenv/builder.rb#4
module Nenv::Builder
  class << self
    # source://nenv//lib/nenv/builder.rb#5
    def build(&block); end
  end
end

# source://nenv//lib/nenv/environment/dumper.rb#2
class Nenv::Environment
  # @return [Environment] a new instance of Environment
  #
  # source://nenv//lib/nenv/environment.rb#21
  def initialize(namespace = T.unsafe(nil)); end

  # source://nenv//lib/nenv/environment.rb#25
  def create_method(meth, &block); end

  private

  # source://nenv//lib/nenv/environment.rb#35
  def _namespaced_sanitize(meth); end

  # source://nenv//lib/nenv/environment.rb#31
  def _sanitize(meth); end

  class << self
    # source://nenv//lib/nenv/environment.rb#44
    def _create_env_accessor(klass, meth, &block); end

    # source://nenv//lib/nenv/environment.rb#40
    def create_method(meth, &block); end

    private

    # source://nenv//lib/nenv/environment.rb#66
    def _create_env_reader(klass, meth, &block); end

    # source://nenv//lib/nenv/environment.rb#56
    def _create_env_writer(klass, meth, &block); end

    # source://nenv//lib/nenv/environment.rb#76
    def _fail_if_accessor_exists(klass, meth); end
  end
end

# source://nenv//lib/nenv/environment.rb#15
class Nenv::Environment::AlreadyExistsError < ::Nenv::Environment::MethodError
  # source://nenv//lib/nenv/environment.rb#16
  def message; end
end

# source://nenv//lib/nenv/environment/dumper.rb#3
module Nenv::Environment::Dumper
  class << self
    # source://nenv//lib/nenv/environment/dumper.rb#6
    def setup(&callback); end
  end
end

# source://nenv//lib/nenv/environment/dumper/default.rb#3
module Nenv::Environment::Dumper::Default
  class << self
    # source://nenv//lib/nenv/environment/dumper/default.rb#4
    def call(raw_value); end
  end
end

# source://nenv//lib/nenv/environment.rb#6
class Nenv::Environment::Error < ::ArgumentError; end

# source://nenv//lib/nenv/environment/loader.rb#3
module Nenv::Environment::Loader
  class << self
    # source://nenv//lib/nenv/environment/loader.rb#7
    def setup(meth, &callback); end
  end
end

# source://nenv//lib/nenv/environment/loader/default.rb#3
module Nenv::Environment::Loader::Default
  class << self
    # source://nenv//lib/nenv/environment/loader/default.rb#4
    def call(raw_value); end
  end
end

# source://nenv//lib/nenv/environment/loader/predicate.rb#3
module Nenv::Environment::Loader::Predicate
  class << self
    # source://nenv//lib/nenv/environment/loader/predicate.rb#4
    def call(raw_value); end
  end
end

# source://nenv//lib/nenv/environment.rb#9
class Nenv::Environment::MethodError < ::Nenv::Environment::Error
  # @return [MethodError] a new instance of MethodError
  #
  # source://nenv//lib/nenv/environment.rb#10
  def initialize(meth); end
end

# source://nenv//lib/nenv/version.rb#2
Nenv::VERSION = T.let(T.unsafe(nil), String)

class Object < ::BasicObject
  include ::Kernel
  include ::DEBUGGER__::TrapInterceptor

  private

  # source://nenv//lib/nenv.rb#6
  def Nenv(namespace = T.unsafe(nil)); end
end
