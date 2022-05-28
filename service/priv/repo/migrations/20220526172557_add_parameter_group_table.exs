defmodule VDiverse.Repo.Migrations.AddParameterGroupTable do
  use Ecto.Migration

  def change do
    create table("parameter_group") do
      add :name,    :string, size: 40
      timestamps()
    end
  end
end
