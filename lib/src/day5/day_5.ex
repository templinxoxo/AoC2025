defmodule Aoc.Day5 do
  @moduledoc """
  Day 5 solutions
  https://adventofcode.com/2025/day/5
  """
  def execute_part_1(data \\ fetch_data()) do
    {ranges, ids} = parse_input(data)

    ranges = ranges |> Enum.sort_by(& &1.from) |> merge_ranges([])

    ids
    |> Enum.filter(fn id ->
      ranges
      |> Enum.any?(fn range ->
        id >= range.from and id <= range.to
      end)
    end)
    |> length()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()
    |> elem(0)
    |> Enum.sort_by(& &1.from)
    |> merge_ranges([])
    |> Enum.map(&(&1.to - &1.from + 1))
    |> Enum.sum()
  end

  def merge_ranges([range1, range2 | rest], merged_ranges) do
    if range1.to >= range2.from do
      merge_ranges(
        [%{from: min(range1.from, range2.from), to: max(range1.to, range2.to)} | rest],
        merged_ranges
      )
    else
      merge_ranges([range2 | rest], [range1 | merged_ranges])
    end
  end

  def merge_ranges(rest, merged_ranges) do
    rest ++ merged_ranges
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
        [from, to] = row |> String.split("-", trim: true) |> Enum.map(&String.to_integer/1)

        %{from: from, to: to}
      end)

    ids = ids |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

    {ranges, ids}
  end
end
