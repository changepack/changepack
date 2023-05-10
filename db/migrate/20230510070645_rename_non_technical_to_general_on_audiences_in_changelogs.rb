class RenameNonTechnicalToGeneralOnAudiencesInChangelogs < ActiveRecord::Migration[7.0]
  def change
    Changelog.where(audience: :non_technical).each do |cl|
      cl.update!(audience: :general)
    end
  end
end
