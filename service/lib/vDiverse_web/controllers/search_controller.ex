defmodule VDiverseWeb.SearchController do
  use VDiverseWeb, :controller

  alias VDiverse.Service.RecommendationService

  def get_recommendations(conn, %{"role" => role}) do

  json(conn |> put_status(200), RecommendationService.get_recommendations(role))
  end

end
