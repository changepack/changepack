Rails.configuration.to_prepare do
  Rails.configuration.event_repository = RailsEventStoreActiveRecord::EventRepository.new(serializer: RubyEventStore::NULL)
  Rails.configuration.event_scheduler = RailsEventStore::ActiveJobScheduler.new(serializer: RubyEventStore::NULL)
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new(
    repository: Rails.configuration.event_repository,
    dispatcher: RubyEventStore::ComposedDispatcher.new(
      RubyEventStore::ImmediateAsyncDispatcher.new(scheduler: Rails.configuration.event_scheduler),
      RubyEventStore::Dispatcher.new
    )
  )

  Dir.glob(Rails.root.join('**', 'on_*.rb'), &method(:require))
end
