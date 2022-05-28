defmodule VDiverseWeb.HealthController do
  use VDiverseWeb, :controller

  def index(conn, _params) do
    json(conn |> put_status(200), "vDiverse is up and running!!")
  end
end
