Fabricator(:component) do
  category
  name          { Faker::Number.number(9) }
  manufacturer  { Faker::Name.last_name }
  description   { Faker::Lorem.sentences(3) }
  image_url     { Faker::Internet.url }
end