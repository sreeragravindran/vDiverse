defmodule VDiverseWeb.MockServer.ResourcePool.Router do
  use VDiverseWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VDiverseWeb do
    pipe_through :api
    get "/recruitment/profile", MockServer.ResourcePool.Controller, :get_profiles
  end
end
