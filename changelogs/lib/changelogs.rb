# frozen_string_literal: true

module Changelogs
  PostCreated = Class.new(RailsEventStore::Event)
  PostDrafted = Class.new(RailsEventStore::Event)
  PostPublished = Class.new(RailsEventStore::Event)
end
