defmodule VDiverseWeb.AdminController do
  use VDiverseWeb, :controller

  alias VDiverse.Models.CreateDiversityGroupRequest
  alias VDiverse.Models.CreateDiversityParamRequest
  alias VDiverse.Service.AdminService

  def get_all_groups(conn, _param) do
    json(conn |> put_status(200), AdminService.get_groups() )
  end

  def get_group_by_id(conn, %{"id" => group_id}) do
    json(conn |> put_status(200), AdminService.get_group_by_id(group_id))
  end

  def add_group(conn, params) do
    changeset = CreateDiversityGroupRequest.from(params, with: &CreateDiversityGroupRequest.changeset/2) |> IO.inspect()
    if changeset.valid? do
      response =
      changeset
        |> Params.to_map()
        |> AdminService.create_group()

      json(
        conn
        |> put_status(200),
        response
      )
    else
      IO.inspect(changeset)
      json(
        conn
        |> put_status(400),
        "invalid request"
      )
    end
  end

  def add_param(conn, params) do
    changeset = CreateDiversityParamRequest.from(params, with: &CreateDiversityParamRequest.changeset/2)
    if changeset.valid? do
      changeset
      |> Params.to_map()
      |> AdminService.create_param()

    json(
      conn
      |> put_status(200),
      "added new group !"
    )
  else
    IO.inspect(changeset)
    json(
      conn
      |> put_status(400),
      "invalid request"
    )
  end
  end

  def update_param(conn, _param) do
    json(conn |> put_status(200), "updated parameter")
  end

  def delete_param(conn, _param) do
    json(conn |> put_status(200), "deleted parameter !")
  end
end
