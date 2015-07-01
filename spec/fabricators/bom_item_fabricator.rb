Fabricator(:bom_item) do
  component
  quantity { (rand() * 9).round + 1 }
end