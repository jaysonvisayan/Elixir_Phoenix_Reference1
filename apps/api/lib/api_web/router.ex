defmodule ApiWeb.Router do
  use ApiWeb, :router

  @csp "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' 'unsafe-eval'"

  if Mix.env == :dev || Mix.env == :test do
    ""
  else
    use Plug.ErrorHandler
    use Sentry.Plug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{
      "content-security-policy" => @csp
    }
    plug ApiWeb.CSPHeader
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ApiWeb do
    pipe_through :api

    scope "/v1", V1 do

      #Benefits
      scope "/benefits" do
        post "/get_benefits", BenefitController, :get_benefits
        post "/create_benefit_acu", BenefitController, :create_benefit_acu
        post "/get_benefits", BenefitController, :get_benefits
        post "/get_benefit_acu", BenefitController, :get_benefit_acu
      end

      #Accounts
      post "/accounts/create_account", AccountController, :create
      post "/accounts/get_accounts", AccountController, :get_accounts
      post "/accounts/get_account", AccountController, :get_account

      post "/exclusions/get_exclusions", ExclusionController, :get_exclusions
      post "/exclusions/create_exclusions", ExclusionController, :create_exclusion

      #PreExistingConditions
      post "/pec/get_pre-existing_conditions", PreExistingConditionController, :get_pre_existing_conditions

      #Exclusion
      post "/exclusions/get_exclusion", ExclusionController, :get_exclusion

      #Plans
      scope "/plans" do
        post "/get_plan", PlanController, :get_plan
        post "/get_plans", PlanController, :get_plans
        post "/create_medical_plan", PlanController, :create_plan
      end

      # PEC
      post "/pec/create_pre-existing_condition", PreExistingConditionController, :create_pre_existing_condition
      post "/pec/get_pre-existing_condition", PreExistingConditionController, :get_pre_existing_condition
    end
  end
end
