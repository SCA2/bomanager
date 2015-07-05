Fabricator(:component) do
  name          { Faker::Number.number(9) }
  manufacturer  { Faker::Name.last_name }
  distributor   { Faker::Name.last_name }
  description   { Faker::Lorem.sentences(3) }
  image_url     { Faker::Internet.url }
  price         { Faker::Commerce.price }
  last_priced   { 2.days.ago }
end