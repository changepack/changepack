# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Inquirer
  include Identifier
  include Timestamp

  primary_abstract_class
  has_paper_trail
end
