class ForbidDefaultsOnSources < ActiveRecord::Migration[7.0]
  def change
    Source.find_each(&:forbid_defaults!)
  end
end
