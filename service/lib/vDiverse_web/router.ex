defmodule VDiverseWeb.Router do
  use VDiverseWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/vDiverse/api", VDiverseWeb do
    pipe_through :api
    get "/", HealthController, :index

    # Admin APIs
    get "/groups", AdminController, :get_all_groups
    get "/groups/:id", AdminController, :get_group_by_id
    put "/group", AdminController, :add_group
    put "/group/:group_id/parameter", AdminController, :add_param
    post "/groups/:group_id/parameters/:id", AdminController, :update_param
    post "/groups/:group_id/parameters/:id", AdminController, :delete_param

    # search APIs
    get "/recommendations", SearchController, :get_recommendations
  end
end
