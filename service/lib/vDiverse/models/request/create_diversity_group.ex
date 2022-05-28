defmodule VDiverse.Models.CreateDiversityGroupRequest do
  @moduledoc false
  import Ecto.Changeset

  use Params.Schema, %{
    name: :string,
    params: [%{
      name: :string,
      type: :string,
      current_percentage: :integer,
      desired_percentage: :integer
    }]
  }

  def changeset(changeset, params) do
    changeset
    |> cast(params, [
      :name
    ])
    |> cast_embed(:params)
    |> validate_required([:name])
  end
end
