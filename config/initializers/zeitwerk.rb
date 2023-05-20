Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'github' => 'GitHub',
    'api' => 'API'
  )
 end
