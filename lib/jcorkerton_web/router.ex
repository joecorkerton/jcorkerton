defmodule JcorkertonWeb.Router do
  use JcorkertonWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", JcorkertonWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", HomepageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", JcorkertonWeb do
  #   pipe_through :api
  # end
end
