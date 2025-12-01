defmodule Aoc.Day1 do
  @moduledoc """
  Day 1 solutions
  https://adventofcode.com/2025/day/1
  """

  @starting_position {50, times_over_zero: 0}
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> get_safe_combination([@starting_position])
    |> Enum.filter(fn {value, times_over_zero: _} -> value == 0 end)
    |> length()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()
    |> get_safe_combination([@starting_position])
    |> Enum.map(fn
      {0, times_over_zero: times_over_zero} -> times_over_zero + 1
      {_value, times_over_zero: times_over_zero} -> times_over_zero
    end)
    |> Enum.sum()
  end

  def get_safe_combination([], combination) do
    Enum.reverse(combination)
  end

  def get_safe_combination([move | moves], [{position, _} | _] = combination) do
    move_to =
      case move do
        {:right, value} -> position + value
        {:left, value} -> position - value
      end

    new_position = move(move_to)
    times_over_zero = times_over_zero(move_to, position)

    get_safe_combination(moves, [{new_position, times_over_zero: times_over_zero}] ++ combination)
  end

  def move(move_to) when move_to < 0, do: rem(move_to + 1000, 100)
  def move(move_to) when move_to >= 100, do: rem(move_to, 100)
  def move(move_to), do: move_to

  def times_over_zero(move_to, move_from) do
    # count number of clicks over 1 full rotations either right or left
    clicks_over_full_rotation = case move_to do
      number when number < 0 -> abs(number) + 100
      number when number > 100 -> number
      _ -> 0
    end

    final_position = move(move_to)

    # factors lowering additional rotations over 0
    starts_at_zero = if move_from == 0 and move_to < 0, do: 1, else: 0
    ends_at_zero = if final_position == 0, do: 1, else: 0

    case floor(clicks_over_full_rotation / 100) do
      0 -> 0
      additional_full_rotations -> additional_full_rotations - starts_at_zero - ends_at_zero
    end
  end

  # # if moving less than 1 rotation left and starting at 0 - no additional passes over 0
  # def times_over_zero(move_to, 0) when move_to < 0 and move_to > -100, do: 0
  # # if making more than 1 full rotation and ending at 0, don't count this as additional passes over 0
  # def times_over_zero(move_to, 0) when move_to <= -100 and rem(move_to, 100) == 0, do: ceil(abs(move_to) / 100) - 2
  # def times_over_zero(move_to, 0) when move_to > 100 and rem(move_to, 100) == 0, do: floor(move_to / 100) - 1
  # # if moving more than 1 full rotation left, count number of full rotations as passes over 0
  # def times_over_zero(move_to, 0) when move_to <= -100, do: ceil(abs(move_to) / 100) - 1
  # def times_over_zero(move_to, _from) when move_to < 0, do: ceil(abs(move_to) / 100)
  # def times_over_zero(move_to, _from) when move_to > 100, do: floor(move_to / 100)
  # def times_over_zero(_move_to, _from), do: 0

  # helpers
  def fetch_data() do
    Aoc.Utils.Api.get_input("1")
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "R" <> value ->
        {:right, String.to_integer(value)}

      "L" <> value ->
        {:left, String.to_integer(value)}
    end)
  end
end
