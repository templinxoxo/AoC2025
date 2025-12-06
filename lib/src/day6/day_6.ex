defmodule Aoc.Day6 do
  @moduledoc """
  Day 6 solutions
  https://adventofcode.com/2025/day/6
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> Enum.map(&solve/1)
    |> Enum.sum()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()

    0
  end

  def solve(task) do
    {numbers, [operation | _]} = Enum.split_while(task, &is_integer/1)

    Enum.reduce(numbers, fn number, acc ->
      case operation do
        :multiply -> acc * number
        :add -> acc + number
      end
    end)
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
      row |> String.split(" ", trim: true) |> Enum.reject(&(&1 == "")) |> Enum.map(&parse/1)
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def parse("*"), do: :multiply
  def parse("+"), do: :add
  def parse(number), do: String.to_integer(number)
end
