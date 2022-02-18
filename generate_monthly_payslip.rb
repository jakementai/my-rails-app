require_relative "calculate_income_tax"

salary = 80_150
tax_bracket = [
  [40, 180_000],
  [30, 80_000],
  [20, 40_000],
  [10, 20_000],
  [0, 0],
]
total_tax = calculate_income_tax(salary, tax_bracket)

puts "Total Tax: #{calculate_income_tax(60000, tax_bracket)}"
puts "Total Tax: #{calculate_income_tax(200000, tax_bracket)}"
puts "Total Tax: #{calculate_income_tax(80150, tax_bracket)}"
