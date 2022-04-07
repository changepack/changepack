# frozen_string_literal: true

class Name < Entity
  param :email
  param :first_name
  param :last_name

  def to_s
    first_name ? [first_name, last_name].join(' ') : email.split('@').first
  end
end
