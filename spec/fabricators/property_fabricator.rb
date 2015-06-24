Fabricator(:property) do
  component
  name  { Faker::Lorem.word }
  value { Faker::Number.number(4) }
end