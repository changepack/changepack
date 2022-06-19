# frozen_string_literal: true

require 'rails_helper'

class DummyCommand < Command
  option :arg, type: Types::String

  def execute; end
end

RSpec.describe CommandJob, type: :job do
  subject(:job) { described_class.new }

  it 'executes commands' do
    command = instance_double(DummyCommand)

    allow(DummyCommand).to receive(:new).and_return(command)
    allow(command).to receive(:execute)

    job.perform('DummyCommand', { arg: 'Dummy argument' })

    expect(command).to have_received(:execute)
  end
end
