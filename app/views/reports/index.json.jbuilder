json.array! @reports do |report|
  json.username report.username
  json.repositories report.repositories do |repo|
    json.id repo.id
    json.name repo.name
    json.tags repo.tags
    json.profile_id repo.profile_id
  end
end
