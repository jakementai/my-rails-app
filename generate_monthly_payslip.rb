require_relative "income_tax"
# Predefine the Tax Bracket
# If args is passed, use th passed args
tax_bracket = ARGV[2].nil? ? [
  [40, 180_000],
  [30, 80_000],
  [20, 40_000],
  [10, 20_000],
  [0, 0],
] : ARGV[2]

ren_income_tax = IncomeTax.new(ARGV[0], ARGV[1].to_i, tax_bracket, !ARGV[2].nil?)
puts "----------------------------------------------------------"
puts "Monthly Payslip for: \"#{ren_income_tax.name}\""
puts sprintf("Gross Monthly Income: $%.2f", ren_income_tax.annual_gross_salary / 12)
puts sprintf("Monthly Income Tax: $%.2f", ren_income_tax.annual_income_tax / 12)
puts sprintf("Net Monthly Income: $%.2f", ren_income_tax.net_monthly_income)
puts "----------------------------------------------------------"
