defmodule VDiverse.Models.CreateDiversityParamRequest do
  @moduledoc false
  import Ecto.Changeset

  use Params.Schema, %{
    group_id: :integer,
    name: :string,
    type: :string,
    current_percentage: :integer,
    desired_percentage: :integer
  }

  def changeset(changeset, params) do
    changeset
    |> cast(params, [
      :group_id,
      :name,
      :type,
      :current_percentage,
      :desired_percentage
    ])
    |> validate_required([:group_id, :name, :type])
  end
end
