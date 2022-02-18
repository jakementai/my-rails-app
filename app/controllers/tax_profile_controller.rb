require_relative '../../income_tax'

class TaxProfileController < ApplicationController
  # include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token

  def index
    data = []
    IncomeTaxProfile.all.each do |tax_profile|
      data << {
        "time_stamp": tax_profile[:updated_at].strftime("%d/%m/%Y %k:%M hrs"),
        "employee_name": format_number(tax_profile[:employee_name]),
        "annual_salary": format_number(tax_profile[:annual_salary]),
        "monthly_income_tax": format_number(tax_profile[:monthly_income_tax])
      }
    end
    

    render json: { data: data}, status: :ok
  end

  def generate_payslip
    # Predefine Income tax range
    tax_bracket = if params['tax_bracket'].nil?
                    [
                      [40, 180_000],
                      [30, 80_000],
                      [20, 40_000],
                      [10, 20_000],
                      [0, 0]
                    ]
                  else
                    params['tax_bracket']
                  end

    # Calculate the payslip
    tax_profile = IncomeTax.new(params['employee_name'], params['gross_income'].to_i, tax_bracket)
    gross_monthly_income = tax_profile.annual_gross_salary / 12
    monthly_income_tax = tax_profile.annual_income_tax / 12
    net_monthly_income = gross_monthly_income - monthly_income_tax

    # Write to db
    IncomeTaxProfile.create(
      employee_name: params[:employee_name],
      annual_salary: params[:gross_income],
      monthly_income_tax: monthly_income_tax
    )

    # Return the data back
    render json: {
      "employee_name": tax_profile.name,
      "gross_monthly_income": format_number(gross_monthly_income),
      "monthly_income_tax": format_number(monthly_income_tax),
      "net_monthly_income": format_number(net_monthly_income)
    }, status: :ok
  end

  private
  def format_number(number)
    number_with_precision(number, precision: 2, separator: '.', delimiter: ',')
  end
end
