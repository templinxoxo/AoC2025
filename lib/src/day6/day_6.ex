defmodule Aoc.Day6 do
  @moduledoc """
  Day 6 solutions
  https://adventofcode.com/2025/day/6
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()

    0
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()

    0
  end

  # helpers
  def fetch_data() do
    day = "6"
    Aoc.Utils.Api.get_input(day)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row
    end)
  end
end
