Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/index", to: "tax_profile#index"
  post "/payslip", to: "tax_profile#generate_payslip"
  post "/monthly_salary", to:"tax_profile#compute_monthly_salary"
end
