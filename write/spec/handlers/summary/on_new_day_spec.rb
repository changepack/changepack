require 'rails_helper'
require 'write/lib/summary/on_new_day'

describe Summary::OnNewDay do
  subject { described_class.new }
  
  let(:account) { create(:account) }
end  

