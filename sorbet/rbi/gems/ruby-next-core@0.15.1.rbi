# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `ruby-next-core` gem.
# Please instead update this file by running `bin/tapioca gem ruby-next-core`.

class NoMatchingPatternError < ::StandardError; end

# source://rubocop/1.36.0/lib/rubocop/ast_aliases.rb#6
RuboCop::ProcessedSource = RuboCop::AST::ProcessedSource

# Add binding argument to all self-less eval's
#
# source://ruby-next-core//lib/ruby-next/version.rb#3
module RubyNext
  class << self
    # source://ruby-next-core//lib/ruby-next/config.rb#28
    def current_ruby_version; end

    # Returns the value of attribute debug_enabled.
    #
    # source://ruby-next-core//lib/ruby-next/logging.rb#8
    def debug_enabled; end

    # source://ruby-next-core//lib/ruby-next/logging.rb#24
    def debug_enabled=(val); end

    # source://ruby-next-core//lib/ruby-next/logging.rb#16
    def debug_source(source, filepath = T.unsafe(nil)); end

    # source://ruby-next-core//lib/ruby-next/config.rb#33
    def next_ruby_version(version = T.unsafe(nil)); end

    # Returns the value of attribute silence_warnings.
    #
    # source://ruby-next-core//lib/ruby-next/logging.rb#7
    def silence_warnings; end

    # Sets the attribute silence_warnings
    #
    # @param value the value to set the attribute silence_warnings to.
    #
    # source://ruby-next-core//lib/ruby-next/logging.rb#7
    def silence_warnings=(_arg0); end

    # source://ruby-next-core//lib/ruby-next/logging.rb#10
    def warn(msg); end

    private

    # Returns the value of attribute debug_filter.
    #
    # source://ruby-next-core//lib/ruby-next/logging.rb#38
    def debug_filter; end
  end
end

# source://ruby-next-core//lib/ruby-next/core.rb#9
module RubyNext::Core
  class << self
    # @return [Boolean]
    #
    # source://ruby-next-core//lib/ruby-next/core.rb#122
    def backports?; end

    # @return [Boolean]
    #
    # source://ruby-next-core//lib/ruby-next/core.rb#118
    def core_ext?; end

    # source://ruby-next-core//lib/ruby-next/core/refinement/import.rb#7
    def import_methods(other, bind); end

    # Inject `using RubyNext` at the top of the source code
    #
    # source://ruby-next-core//lib/ruby-next/core.rb#131
    def inject!(contents); end

    # source://ruby-next-core//lib/ruby-next/core.rb#126
    def patch(*_arg0, **_arg1, &_arg2); end

    # source://ruby-next-core//lib/ruby-next/core.rb#140
    def patches; end

    # @return [Boolean]
    #
    # source://ruby-next-core//lib/ruby-next/core.rb#114
    def refine?; end

    # Returns the value of attribute strategy.
    #
    # source://ruby-next-core//lib/ruby-next/core.rb#107
    def strategy; end

    # @raise [ArgumentError]
    #
    # source://ruby-next-core//lib/ruby-next/core.rb#109
    def strategy=(val); end
  end
end

# Patch contains the extension implementation
# and meta information (e.g., Ruby version).
#
# source://ruby-next-core//lib/ruby-next/core.rb#12
class RubyNext::Core::Patch
  # Create a new patch for module/class (mod)
  # with the specified uniq name
  #
  # `core_ext` defines the strategy for core extensions:
  #    - :patch — extend class directly
  #    - :prepend — extend class by prepending a module (e.g., when needs `super`)
  #
  # @return [Patch] a new instance of Patch
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#21
  def initialize(mod = T.unsafe(nil), method:, version:, name: T.unsafe(nil), supported: T.unsafe(nil), native: T.unsafe(nil), location: T.unsafe(nil), refineable: T.unsafe(nil), core_ext: T.unsafe(nil), singleton: T.unsafe(nil)); end

  # Returns the value of attribute body.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def body; end

  # Returns the value of attribute core_ext.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def core_ext; end

  # @return [Boolean]
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#43
  def core_ext?; end

  # Returns the value of attribute location.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def location; end

  # Returns the value of attribute method_name.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def method_name; end

  # Returns the value of attribute mod.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def mod; end

  # Returns the value of attribute name.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def name; end

  # Returns the value of attribute native.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def native; end

  # Returns the value of attribute native.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def native?; end

  # @return [Boolean]
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#39
  def prepend?; end

  # Returns the value of attribute refineables.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def refineables; end

  # Returns the value of attribute singleton.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def singleton; end

  # Returns the value of attribute singleton.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def singleton?; end

  # Returns the value of attribute supported.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def supported; end

  # Returns the value of attribute supported.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def supported?; end

  # source://ruby-next-core//lib/ruby-next/core.rb#51
  def to_module; end

  # Returns the value of attribute version.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#13
  def version; end

  private

  # source://ruby-next-core//lib/ruby-next/core.rb#68
  def build_location(trace_locations); end

  # source://ruby-next-core//lib/ruby-next/core.rb#61
  def build_module_name; end

  # @return [Boolean]
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#80
  def native_location?(location); end
end

# Registry for patches
#
# source://ruby-next-core//lib/ruby-next/core.rb#86
class RubyNext::Core::Patches
  # @return [Patches] a new instance of Patches
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#89
  def initialize; end

  # Register new patch
  #
  # @raise [ArgumentError]
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#96
  def <<(patch); end

  # Returns the value of attribute extensions.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#87
  def extensions; end

  # Returns the value of attribute refined.
  #
  # source://ruby-next-core//lib/ruby-next/core.rb#87
  def refined; end
end

# Defines last minor version for every major version
#
# source://ruby-next-core//lib/ruby-next/config.rb#11
RubyNext::LAST_MINOR_VERSIONS = T.let(T.unsafe(nil), Hash)

# source://ruby-next-core//lib/ruby-next/config.rb#16
RubyNext::LATEST_VERSION = T.let(T.unsafe(nil), Array)

# Language module contains tools to transpile newer Ruby syntax
# into an older one.
#
# It works the following way:
#   - Takes a Ruby source code as input
#   - Generates the AST using the edge parser (via the `parser` gem)
#   - Pass this AST through the list of processors (one feature = one processor)
#   - Each processor may modify the AST
#   - Generates a transpiled source code from the transformed AST (via the `unparser` gem)
#
# source://ruby-next-core//lib/ruby-next/language/setup.rb#8
module RubyNext::Language
  class << self
    # @return [Boolean]
    #
    # source://ruby-next-core//lib/ruby-next/language/setup.rb#26
    def runtime?; end

    # source://ruby-next-core//lib/ruby-next/language/setup.rb#31
    def setup_gem_load_path(lib_dir = T.unsafe(nil), rbnext_dir: T.unsafe(nil), transpile: T.unsafe(nil)); end
  end
end

# Module responsible for transpiling a library at load time
#
# source://ruby-next-core//lib/ruby-next/language/setup.rb#10
module RubyNext::Language::GemTranspiler
  class << self
    # source://ruby-next-core//lib/ruby-next/language/setup.rb#11
    def maybe_transpile(root_dir, lib_dir, target_dir); end
  end
end

# Mininum Ruby version supported by RubyNext
#
# source://ruby-next-core//lib/ruby-next/config.rb#5
RubyNext::MIN_SUPPORTED_VERSION = T.let(T.unsafe(nil), Gem::Version)

# A virtual version number used for proposed features
#
# source://ruby-next-core//lib/ruby-next/config.rb#19
RubyNext::NEXT_VERSION = T.let(T.unsafe(nil), String)

# Where to store transpiled files (relative from the project LOAD_PATH, usually `lib/`)
#
# source://ruby-next-core//lib/ruby-next/config.rb#8
RubyNext::RUBY_NEXT_DIR = T.let(T.unsafe(nil), String)

# source://ruby-next-core//lib/ruby-next/utils.rb#4
module RubyNext::Utils
  private

  # Returns true if modules refinement is supported in current version
  #
  # source://ruby-next-core//lib/ruby-next/utils.rb#38
  def refine_modules?; end

  # source://ruby-next-core//lib/ruby-next/utils.rb#8
  def resolve_feature_path(feature); end

  # source://ruby-next-core//lib/ruby-next/utils.rb#29
  def source_with_lines(source, path); end

  class << self
    # Returns true if modules refinement is supported in current version
    #
    # @return [Boolean]
    #
    # source://ruby-next-core//lib/ruby-next/utils.rb#38
    def refine_modules?; end

    # source://ruby-next-core//lib/ruby-next/utils.rb#8
    def resolve_feature_path(feature); end

    # source://ruby-next-core//lib/ruby-next/utils.rb#29
    def source_with_lines(source, path); end
  end
end

# source://ruby-next-core//lib/ruby-next/version.rb#4
RubyNext::VERSION = T.let(T.unsafe(nil), String)
