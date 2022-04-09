# frozen_string_literal: true

class ApplicationPolicy < ActionPolicy::Base
  authorize :user, allow_nil: true

  def record_is_instance?
    record.class != Class && record.class != Module
  end

  def record_is_class?
    !record_is_instance? || record.nil?
  end
end
