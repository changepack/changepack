Normatron.setup do |config|
  # Comment the line below to disable Normatron
  config.add_orm Normatron::Extensions::ActiveRecord

  # Create your own filters using a Proc/lambda as following: 
  # 
  # config.filters[:smile] = lambda do |value|
  #   value.kind_of?(String) : value + " =]" : value
  # end

  # Include your own filter module as following:
  #
  # config.filters[:laugh] = YourNamespace::YourFilterSet::YourFilter

  # Set the default filters.
  #
  # Examples:
  #   config.default_filters = :upcase, {:keep => [:L, :N]}
  #   config.default_filters = :ascii,  [:keep, :L, :N]
  config.default_filters = :blank, :squish
end