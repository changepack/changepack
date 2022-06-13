# config/initializers/zeitwerk.rb
Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'github' => 'GitHub'
  )
 end
