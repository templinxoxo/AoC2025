defmodule Aoc.Day2 do
  @moduledoc """
  Day 2 solutions
  https://adventofcode.com/2025/day/2
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> Enum.map(&find_invalid_ids/1)
    |> List.flatten()
    |> Enum.sum()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()

    0
  end

  def find_invalid_ids({first, last}) do
    first..last
    |> Enum.filter(&is_invalid_id?/1)
  end

  def is_invalid_id?(id) when is_integer(id) do
    id = Integer.to_string(id)
    {first, last} = String.split_at(id, floor(String.length(id) / 2))

    first == last
  end

  # helpers
  def fetch_data() do
    day = "2"
    Aoc.Utils.Api.get_input(day)
  end

  def parse_input(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(fn row ->
      String.split(row, ~r"-|\n", trim: true)
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end
