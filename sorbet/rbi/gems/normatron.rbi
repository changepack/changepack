# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/normatron/all/normatron.rbi
#
# normatron-0.3.4

module Normatron
end
module Normatron::Filters
end
module Normatron::Filters::AsciiFilter
end
module Normatron::Filters::BlankFilter
end
module Normatron::Filters::Helpers
end
module Normatron::Filters::CamelizeFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::CapitalizeFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::ChompFilter
end
module Normatron::Filters::DasherizeFilter
end
module Normatron::Filters::DowncaseFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::DumpFilter
end
module Normatron::Filters::KeepFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::RemoveFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::SqueezeFilter
end
module Normatron::Filters::SquishFilter
end
module Normatron::Filters::StripFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::SwapcaseFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::TitleizeFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::UnderscoreFilter
  extend Normatron::Filters::Helpers
end
module Normatron::Filters::UpcaseFilter
  extend Normatron::Filters::Helpers
end
class Normatron::Configuration
end
module Normatron::Extensions
end
module Normatron::Extensions::ActiveRecord
end
module Normatron::Extensions::ActiveRecord::ClassMethods
end
module Normatron::Extensions::ActiveRecord::InstanceMethods
end
class Normatron::Extensions::UnknownAttributeError < RuntimeError
end
class Normatron::Extensions::UnknownFilterError < RuntimeError
end