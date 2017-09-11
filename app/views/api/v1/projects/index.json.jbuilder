json.projects do
  json.array! @projects, :id, :name, :created_at
end