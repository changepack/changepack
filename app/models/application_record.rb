# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Inquirer
  include Identifier

  primary_abstract_class
  has_paper_trail
end
