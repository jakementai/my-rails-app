require_relative "../../../../income_tax"

module Api::V1
  class TaxProfileController < ApplicationController
    # include ActionView::Helpers::NumberHelper
    skip_before_action :verify_authenticity_token

    def index
      @income_tax_profiles = []
      @count = 1
      IncomeTaxProfile.all.each do |tax_profile|
        @income_tax_profiles << tax_profile.to_json
      end
      # render "index"
    end

    def show
      @tax_profile = (IncomeTaxProfile.find(params[:id])).to_json
    end

    def delete_record
      IncomeTaxProfile.destroy(params[:id])
      redirect_to api_v1_index_path
    end

    def generate_payslip
      tax_profile_param = params[:tax_profile]
      # Calculate the payslip
      if !tax_profile_param[:tax_bracket].empty?
        tax_profile = IncomeTax.new(tax_profile_param[:employee_name], tax_profile_param[:gross_annual_income].to_i, tax_profile_param[:tax_bracket], true)
      else
        tax_profile = IncomeTax.new(tax_profile_param[:employee_name], tax_profile_param[:gross_annual_income].to_i)
      end

      # Insert into DB
      new_profile = IncomeTaxProfile.create(
        employee_name: tax_profile_param[:employee_name],
        annual_salary: tax_profile_param[:gross_annual_income],
        monthly_income_tax: tax_profile.monthly_income_tax,
        tax_bracket: tax_profile.tax_bracket,
      )

      # Return the data back
      redirect_to api_v1_path(new_profile.id)
    end
  end
end
