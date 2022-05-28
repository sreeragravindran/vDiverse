defmodule VDiverseWeb.MockServer.ResourcePool.Controller do
  use VDiverseWeb, :controller

  @default_profiles [%{
    "name": "Benjamin",
    "gender": "male",
    "age": 26
  },%{
    "name": "Sophia",
    "gender": "female",
    "age": 29
  },%{
    "name": "Olivia",
    "gender": "female",
    "age": 43
  },%{
    "name": "Emma",
    "gender": "female",
    "age": 34
  },%{
    "name": "Jack",
    "gender": "male",
    "age": 52
  }]


  @sde2 [%{
    "name": "Dilip",
    "gender": "male",
    "age": 31
  },%{
    "name": "Kara",
    "gender": "female",
    "age": 29
  },%{
    "name": "Sharon",
    "gender": "female",
    "age": 38
  },%{
    "name": "Amy",
    "gender": "female",
    "age": 43
  },%{
    "name": "John",
    "gender": "male",
    "age": 40
  }]


  def get_profiles(conn, %{"role" => "sde1"} = param) do
    json(conn |> put_status(200), @default_profiles)
  end

  def get_profiles(conn, %{"role" => "sde2"} = param) do
    json(conn |> put_status(200), @sde2)
  end

  def get_profiles(conn, _) do
    json(conn |> put_status(200), @default_profiles)
  end
end
