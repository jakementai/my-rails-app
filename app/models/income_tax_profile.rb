class IncomeTaxProfile < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  def net_annual_salary
    format_number(attributes["annual_salary"] - attributes["monthly_income_tax"] * 12.0)
  end

  def net_monthly_salary
    format_number(attributes["annual_salary"] / 12.0 - attributes["monthly_income_tax"])
  end

  def annual_income_tax
    format_number(attributes["monthly_income_tax"] * 12.0)
  end

  def gross_monthly_salary
    format_number(attributes["annual_salary"] / 12.0)
  end

  def to_json
    {
      "id": attributes["id"],
      "employee_name": attributes["employee_name"],
      "updated_at": attributes["updated_at"].strftime("%d/%m/%Y %I:%M %p"),
      "gross_annual_salary": format_number(attributes["annual_salary"]),
      "annual_income_tax": annual_income_tax,
      "net_annual_salary": net_annual_salary,
      "gross_monthly_salary": gross_monthly_salary,
      "monthly_income_tax": format_number(attributes["monthly_income_tax"]),
      "net_monthly_salary": net_monthly_salary,
    }
  end

  private

  def format_number(number)
    number_with_precision(number, precision: 2, separator: ".", delimiter: ",")
  end
end
