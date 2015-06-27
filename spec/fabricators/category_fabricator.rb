Fabricator(:category) do
  name { Faker::Name.last_name }
  components(count: 5)
end