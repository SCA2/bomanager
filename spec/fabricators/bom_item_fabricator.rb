Fabricator(:bom_item) do
  bom
  component
  quantity { (rand() * 9).round + 1 }
end