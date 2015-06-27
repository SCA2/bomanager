Fabricator(:bom) do
  user
  name { Faker::Name.last_name }
end