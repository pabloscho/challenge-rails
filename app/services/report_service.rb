require 'external/client'

class ReportService
  def generate
    external_client = ::External::Client.new
    profiles = external_client.fetch_profiles
    repositories = external_client.fetch_repositories

    profiles.map do |profile|
      {
        username: profile['username'],
        repositories: repositories
          .filter { |x| x['profile_id'] == profile['id'] }
          .map do |repo|
            {
              name: repo['name'],
              tags: repo['tags']
            }
          end
      }
    end
  end
end
