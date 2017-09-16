Fabricator(:bank) do
  amount { rand(10) }
  dimension { [1, 2, 5, 10, 25, 50].sample }
end
