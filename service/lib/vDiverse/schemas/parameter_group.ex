defmodule VDiverse.Schemas.ParameterGroup do
  @moduledoc false

  use Ecto.Schema
  require Logger
  import Ecto.Changeset

  schema "parameter_group" do
    field :name, :string
    timestamps()
  end


  @doc false
  def changeset(parameter_group, attrs) do
    parameter_group
    |> cast(attrs, [
      :name
    ])
    |> validate_required([:name])
  end


end
