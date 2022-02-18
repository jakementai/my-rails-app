# Function
# Calculate total income - (salary, tax_brackets[])
=begin
assuming
tax_bracket = [
    [tax_rate, lower_limit]
    [40, 180000],
    [30, 80000],
    [20, 40000],
    [10, 20000],    => 20000 - 40000, tax = 10%
    [0, 0],         => 0 - 20000, tax = 0%
]

Calculation:
Salary = 60000
tax_bracket = [
    [40, 180000],
    [30, 80000],
    [20, 40000],
    [10, 20000],    
    [0, 0], 
]

Remaining_salary = salary
total_tax = 0
foreach tax_bracket => brackets
    Taxible = Remaining Salary - bracket[1] //60000 - 180000 = -12k | 60000 - 40000 = 20000 | 60000 - 20000
    if taxible > 0:
        total_tax = taxible * bracket[0]
        remaining_salary -= Taxible
    end

//foreach


- if > 180000
    - Tax rate = 40%
    - taxible_amount = salary - 18000
    - total_tax_amt = taxible_amount * tax_rate + 
- if > 80000
    - tax rate = 30%
- if > 40000
    - tax rate = 20%
- if > 20000
    - tax rate = 10%
- if > 0
    - tax rate = 0%
=end

def calculate_income_tax(salary, tax_bracket = [])
  # Variables
  remaining_salary = salary
  total_tax = 0

  tax_bracket.each do |bracket|
    taxible_income = remaining_salary - bracket[1]
    tax_rate = bracket[0] / 100.00
    if taxible_income.positive?
      total_tax += taxible_income * tax_rate
      remaining_salary -= taxible_income
    end

    # puts taxible_income
    # puts tax_rate
    # puts total_tax
    # puts "---------------------"
  end

  return total_tax
end
