class RenameGeneralToMainstreamOnAudiencesInChangelogs < ActiveRecord::Migration[7.0]
  def change
    Changelog.where(audience: :general).each do |cl|
      cl.update!(audience: :mainstream)
    end
  end
end
