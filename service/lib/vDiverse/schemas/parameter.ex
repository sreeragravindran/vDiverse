defmodule VDiverse.Schemas.Parameter do
  @moduledoc false

  use Ecto.Schema
  require Logger
  import Ecto.Changeset

  schema "parameter" do
    belongs_to :group, VDiverse.Schemas.ParameterGroup
    field :type, :string
    field :name, :string
    field :current_percentage, :integer
    field :desired_percentage, :integer
    timestamps()
  end


  @doc false
  def changeset(parameter, attrs) do
    parameter
    |> cast(attrs, [
      :group_id,
      :type,
      :name,
      :current_percentage,
      :desired_percentage
    ])
    |> foreign_key_constraint(:group_id)
  end


end
