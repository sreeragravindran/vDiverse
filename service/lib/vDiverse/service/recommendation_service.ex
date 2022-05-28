defmodule VDiverse.Service.RecommendationService do

  import Ecto.Query

  alias VDiverse.Schemas.ParameterGroup
  alias VDiverse.Schemas.Parameter
  alias VDiverse.Repo
  alias VDiverse.RestClients.ProfileClient
  alias VDiverse.Service.AdminService


  def get_recommendations(role) do
    # get eligible resources for the role
    {:ok, 200, {:ok, profiles}} = ProfileClient.get_profiles(role)
    # |> IO.inspect(label: "profiles from mock")

    # get org level groups & parameters
    groups = AdminService.get_groups()

    # find out the deviation per metric & sum for group level
    Enum.map(groups, &get_deviation_for_group/1)
    |> sort_by_deviation()
    |> IO.inspect(label: "get_deviation_for_group")

    # sort based on the group with highest disparity
    |> get_sorted_profiles(profiles)
  end

  def get_sorted_profiles(groups, profiles) when length(groups) == 0 do
    profiles
  end

  def get_sorted_profiles(groups_with_deviation, profiles) do

    IO.inspect(groups_with_deviation, label: "groups_with_deviation")
    IO.inspect(profiles, label: "profiles")


    [group_with_most_disparity | tail ]= groups_with_deviation;
    # IO.inspect
    Enum.map(group_with_most_disparity.params, fn param ->
      filtered_profiles = Enum.filter(profiles, fn profile ->
        does_profile_match_the_parameter(profile, param, group_with_most_disparity.name)
      end)
      |> IO.inspect(label: "filtered profiles" )
      get_sorted_profiles(tail, filtered_profiles)
    end)
    |> List.flatten()
  end

  def does_profile_match_the_parameter(profile, %{:type => "string"} = param, group_name) do
      IO.inspect("string profile matcher")
      profile[group_name] == param.name
  end

  # if the value from profile falls in the range
  def does_profile_match_the_parameter(profile, %{:type => "range"} = param, group_name) do
    IO.inspect("range profile matcher")
    [first | last] = String.split(param.name, "-")
    IO.inspect({first, last, profile[group_name]})
    profile[group_name] >= String.to_integer(first) &&
    profile[group_name] <= String.to_integer(Enum.at(last, 0))
  end

  # returns a map with total deviation for the group as well as at param levels
  def get_deviation_for_group(group) do

    # todo: compute this
    {total_deviation, new_params} =
      Enum.reduce(group.params, {0, []}, fn param, {total_dev, param_list} ->
        deviation = (param.desired_percentage - param.current_percentage)/param.current_percentage
        new_total =
          if deviation > 0 do
            total_dev+deviation
          else
            total_dev
          end
        {new_total, param_list ++ [Map.put_new(param, :deviation, deviation)]}
      end)

      Map.put_new(group, :deviation, total_deviation)
      |> Map.put(:params, new_params |> sort_by_deviation())


      # %{
      #   name: "gender",
      #   deviation: 2,
      #   params: [
      #     %{
      #       name: "female",
      #       type: "string",
      #       deviation: 2
      #     },
      #     %{
      #       name: "male",
      #       type: "string",
      #       deviation: -0.5
      #     }
      #   ]
      # }
  end

  # def get_deviation_for_group(_) do


  #   # todo: compute this
  #     %{
  #       name: "age",
  #       deviation: 3,
  #       params: [
  #         %{
  #           name: "20-40",
  #           type: "range",
  #           deviation: 3
  #         },
  #         %{
  #           name: "41-60",
  #           type: "range",
  #           deviation: -0.5
  #         }
  #       ]
  #     }
  # end

  def sort_by_deviation(array) do
      Enum.sort_by(array, &(&1.deviation), :desc) |> IO.inspect
  end
end
