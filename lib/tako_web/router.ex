defmodule TakoWeb.Router do
  use TakoWeb, :router

  pipeline :api do
    plug CORSPlug,
      origin: "*"

    # origin: ["http://localhost", "https://localhost", "https://holoquest.hololivefanbooth.com"]

    plug :accepts, ["json"]
  end

  scope "/api/json" do
    pipe_through(:api)

    forward "/accounts", Tako.Accounts.Router
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:tako, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TakoWeb.Telemetry
    end
  end
end
