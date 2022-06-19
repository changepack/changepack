# frozen_string_literal: true

class CommandJob
  include Sidekiq::Job

  def perform(command, args)
    command.constantize.new(**args).execute
  end
end
