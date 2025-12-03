defmodule Aoc.Day3 do
  @moduledoc """
  Day 3 solutions
  https://adventofcode.com/2025/day/3
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> Enum.map(&(find_max_joltage(&1, 2) |> to_int()))
    |> Enum.sum()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()
    |> Enum.map(&(find_max_joltage(&1, 12) |> to_int()))
    |> Enum.sum()
  end

  def find_max_joltage(_numbers, 0), do: []

  def find_max_joltage(numbers, index_from_back) do
    max_number =
      numbers
      |> Enum.slice(0..(0 - index_from_back)//1)
      |> Enum.max()

    index = Enum.find_index(numbers, &(&1 == max_number))
    remaining_numbers = Enum.slice(numbers, (index + 1)..-1//1)

    [max_number] ++ find_max_joltage(remaining_numbers, index_from_back - 1)
  end

  def to_int(list), do: list |> Enum.join("") |> String.to_integer()

  # helpers
  def fetch_data() do
    day = "3"
    Aoc.Utils.Api.get_input(day)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      String.split(row, "", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
