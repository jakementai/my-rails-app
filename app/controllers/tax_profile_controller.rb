require_relative '../../income_tax'

class TaxProfileController < ApplicationController
  # include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token

  def index
    render json: { status: 'SUCCESS', message: 'Test Message', data: 'Example Data' }, status: :ok
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
      "gross_monthly_income": number_with_precision(gross_monthly_income, precision: 2, separator: '.', delimiter: ','),
      "monthly_income_tax": number_with_precision(monthly_income_tax, precision: 2, separator: '.', delimiter: ','),
      "net_monthly_income": number_with_precision(net_monthly_income, precision: 2, separator: '.', delimiter: ',')
    }, status: :ok
  end

  def compute_monthly_salary
    
  end
end
