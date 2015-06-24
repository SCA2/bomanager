Fabricator(:category) do
  name { Faker::Name.name }
  components(count: 5)
end