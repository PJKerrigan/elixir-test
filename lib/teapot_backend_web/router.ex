defmodule TeapotBackendWeb.Router do
  use TeapotBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TeapotBackendWeb do
    pipe_through :api
  end
end
