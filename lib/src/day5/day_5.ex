defmodule Aoc.Day5 do
  @moduledoc """
  Day 5 solutions
  https://adventofcode.com/2025/day/5
  """
  def execute_part_1(data \\ fetch_data()) do
    {ranges, ids} = parse_input(data)

    ids
    |> Enum.filter(fn id ->
      ranges
      |> Enum.any?(fn [first, last] ->
        id >= first and id <= last
      end)
    end)
    |> length()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()

    0
  end

  # helpers
  def fetch_data() do
    day = "5"
    Aoc.Utils.Api.get_input(day)
  end

  def parse_input(input) do
    [ranges, ids] = String.split(input, "\n\n", trim: true)

    ranges =
      ranges
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        row |> String.split("-", trim: true) |> Enum.map(&String.to_integer/1)
      end)

    ids = ids |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

    {ranges, ids}
  end
end
