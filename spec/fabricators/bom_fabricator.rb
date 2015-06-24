Fabricator(:bom) do
  user
  name { Faker::Name.name }
end