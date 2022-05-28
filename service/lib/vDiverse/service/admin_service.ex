defmodule VDiverse.Service.AdminService do

  import Ecto.Query

  alias VDiverse.Schemas.ParameterGroup
  alias VDiverse.Schemas.Parameter
  alias VDiverse.Repo
  alias VDiverse.Service.RecommendationService

  # gets all groups and its parameters
  def get_groups() do
    query = from pg in ParameterGroup
    Repo.all(query)
    |> Enum.map(fn x -> Map.from_struct(x) |> Map.drop([:__meta__, :inserted_at, :updated_at]) end)
    |> Enum.map(fn x -> Map.put_new(x, :params, get_params_for_group(x.id)) end)
    |> Enum.map(&RecommendationService.get_deviation_for_group/1)
  end

  def get_params_for_group(group_id) do
    query = from p in Parameter,
           where: p.group_id == ^group_id

    Repo.all(query)
    |> IO.inspect()
    |> Enum.map(fn x ->  Map.from_struct(x) |> Map.drop([:__meta__, :inserted_at, :updated_at, :group, :group_id]) end )
    |> IO.inspect()

  end

  def get_group_by_id(group_id) do
    Repo.get(ParameterGroup, group_id)
    |> Map.from_struct()
    |> Map.drop([:__meta__, :inserted_at, :updated_at])
    |> Map.put_new(:params, get_params_for_group(group_id))
  end


  def create_group(group_params) do
    group_changeset = ParameterGroup.changeset(%ParameterGroup{}, group_params)
    {:ok, group} = Repo.insert(group_changeset, []) |> IO.inspect()

    create_params(group.id, group_params)
    get_group_by_id(group.id)
  end

  def create_params(group_id, %{:params => params}) do
    Enum.each(params, fn param ->
      updated_params = Map.put_new(param, :group_id, group_id)
      create_param(updated_params)
     end)
  end

  def create_params(_group_id, _group_params), do: :ok

  def create_param(params) do
    param_changeset = Parameter.changeset(%Parameter{}, params)
    Repo.insert(param_changeset, [])
  end
end
