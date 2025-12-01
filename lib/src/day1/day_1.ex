defmodule Aoc.Day1 do
  @moduledoc """
  Day 1 solutions
  https://adventofcode.com/2025/day/1
  """

  @starting_position 50
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> get_safe_combination([@starting_position])
    |> Enum.filter(fn value -> value == 0 end)
    |> length()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()

    0
  end
  def get_safe_combination([], combination) do
    Enum.reverse(combination)
  end

  def get_safe_combination([move | moves], [position  | _] = combination) do
    new_position = case move do
      { :right, value } -> rem(position + value,  100)
      { :left, value } -> rem(position - value + 100, 100)
    end

    get_safe_combination(moves, [new_position] ++ combination)
  end

  # helpers
  def fetch_data() do
    Aoc.Utils.Api.get_input("1")
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn "R"<>value ->
      { :right, String.to_integer(value) }
    "L"<>value ->
      { :left, String.to_integer(value) }
    end)
    |> IO.inspect()
  end
end
