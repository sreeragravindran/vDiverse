defmodule VDiverse.RestClients.ProfileClient do
  require Logger
  use HTTPoison.Base

   def process_request_url(url) do
     Application.get_env(:vDiverse, :profile)[:base_url] <> url
   end

   def process_request_body(body) do
    body |> Jason.encode!()
  end

  def process_response_body(body) do
    body |> Jason.decode()
  end

  def get_profiles(role_id) do
    path = "/recruitment/profile?role=#{role_id}"
    case get(path, []) do
      {:ok, response} ->
        {:ok, response.status_code, response.body}
      {:error, error} ->
        {:error, error}
    end
  end

end
