# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/stringex/all/stringex.rbi
#
# stringex-2.8.5

module Stringex
end
module Stringex::Localization
  include Stringex::Localization::DefaultConversions
end
module Stringex::Localization::ConversionExpressions
end
class Stringex::Localization::Converter
  include Stringex::Localization::ConversionExpressions
end
module Stringex::Localization::DefaultConversions
end
module Stringex::Localization::Backend
end
class Stringex::Localization::Backend::Base
end
class Stringex::Localization::Backend::Internal < Stringex::Localization::Backend::Base
end
class Stringex::Localization::Backend::I18n < Stringex::Localization::Backend::Base
end
class Stringex::Localization::Backend::I18nNotDefined < RuntimeError
end
class Stringex::Localization::Backend::I18nMissingTranslate < RuntimeError
end
module Stringex::Unidecoder
end
module Stringex::StringExtensions
end
module Stringex::StringExtensions::PublicInstanceMethods
end
module Stringex::Configuration
end
class Stringex::Configuration::Base
end
class Stringex::Configuration::Configurator
end
class Stringex::Configuration::ActsAsUrl < Stringex::Configuration::Base
end
class Stringex::Configuration::StringExtensions < Stringex::Configuration::Base
end
module Stringex::StringExtensions::PublicClassMethods
end
module Stringex::ActsAsUrl
end
module Stringex::ActsAsUrl::Adapter
end
class Stringex::ActsAsUrl::Adapter::Base
end
class Stringex::ActsAsUrl::Adapter::ActiveRecord < Stringex::ActsAsUrl::Adapter::Base
end
class Stringex::ActsAsUrl::Adapter::DataMapper < Stringex::ActsAsUrl::Adapter::Base
end
class Stringex::ActsAsUrl::Adapter::Mongoid < Stringex::ActsAsUrl::Adapter::Base
end
module Stringex::ActsAsUrl::ActsAsUrlClassMethods
end
module Stringex::ActsAsUrl::ActsAsUrlInstanceMethods
end
module Stringex::Version
end
class String
  extend Stringex::StringExtensions::PublicClassMethods
  include Stringex::StringExtensions::PublicInstanceMethods
end
class Stringex::Railtie < Rails::Railtie
end
class ActiveRecord::Base
  extend Stringex::ActsAsUrl::ActsAsUrlClassMethods
  include Stringex::ActsAsUrl::ActsAsUrlInstanceMethods
end