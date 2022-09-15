# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `prettyid` gem.
# Please instead update this file by running `bin/tapioca gem prettyid`.

# source://prettyid//lib/pretty_id/version.rb#1
module PrettyId
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::PrettyId::ClassMethods

  # source://prettyid//lib/pretty_id.rb#35
  def _create_record(*_arg0); end

  private

  # source://prettyid//lib/pretty_id.rb#48
  def set_pretty_id; end
end

# source://prettyid//lib/pretty_id.rb#0
module PrettyId::ClassMethods
  # source://prettyid//lib/pretty_id.rb#22
  def id_prefix; end

  # source://prettyid//lib/pretty_id.rb#18
  def id_prefix=(prefix); end

  # source://prettyid//lib/pretty_id.rb#30
  def id_separator; end

  # source://prettyid//lib/pretty_id.rb#26
  def id_separator=(separator); end
end

# source://prettyid//lib/pretty_id/generator.rb#2
class PrettyId::Generator
  # @return [Generator] a new instance of Generator
  #
  # source://prettyid//lib/pretty_id/generator.rb#5
  def initialize(record); end

  # source://prettyid//lib/pretty_id/generator.rb#9
  def id; end

  # source://prettyid//lib/pretty_id/generator.rb#13
  def length; end

  # source://prettyid//lib/pretty_id/generator.rb#17
  def prefix; end

  # Returns the value of attribute record.
  #
  # source://prettyid//lib/pretty_id/generator.rb#3
  def record; end

  # source://prettyid//lib/pretty_id/generator.rb#25
  def separator; end
end

# taken from Ruby 2.5 implementation
#
# source://prettyid//lib/pretty_id/sec_random.rb#5
class PrettyId::SecRandom
  class << self
    # source://prettyid//lib/pretty_id/sec_random.rb#8
    def alphanumeric(n = T.unsafe(nil)); end

    # source://prettyid//lib/pretty_id/sec_random.rb#13
    def choose(source, n); end
  end
end

# source://prettyid//lib/pretty_id/sec_random.rb#6
PrettyId::SecRandom::ALPHANUMERIC = T.let(T.unsafe(nil), Array)

# source://prettyid//lib/pretty_id/version.rb#2
PrettyId::VERSION = T.let(T.unsafe(nil), String)
