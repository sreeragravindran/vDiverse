defmodule VDiverse.Repo.Migrations.AddParametersTable do
  use Ecto.Migration

  def change do
    create table("parameter") do
    add :group_id, references(:parameter_group)
    add :type, :string
    add :name, :string
    add :current_percentage, :integer
    add :desired_percentage, :integer
    timestamps()
    end
  end
end
