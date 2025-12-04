defmodule Aoc.Day4 do
  @moduledoc """
  Day 4 solutions
  https://adventofcode.com/2025/day/4
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> get_paper_rolls_coordinates()
    |> get_available_paper_rolls_coordinates()
    |> length()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()
    |> get_paper_rolls_coordinates()
    |> remove_all_paper_rolls()
    |> length()
  end

  def remove_all_paper_rolls([]) do
    []
  end

  def remove_all_paper_rolls(paper_rolls_coordinates) do
    case get_available_paper_rolls_coordinates(paper_rolls_coordinates) do
      [] ->
        []

      rolls_removed_in_current_step ->
        remove_all_paper_rolls(paper_rolls_coordinates -- rolls_removed_in_current_step) ++
          rolls_removed_in_current_step
    end
  end

  @max_nearby_rolls_count 4
  def get_available_paper_rolls_coordinates(paper_rolls_coordinates) do
    paper_rolls_coordinates
    |> Enum.filter(fn coordinates ->
      coordinates
      |> get_nearby_coordinates()
      |> Enum.filter(&(&1 in paper_rolls_coordinates))
      |> length()
      |> Kernel.<(@max_nearby_rolls_count)
    end)
  end

  def get_nearby_coordinates({x, y}) do
    Enum.map(-1..1, fn dx ->
      Enum.map(-1..1, fn dy ->
        {x + dx, y + dy}
      end)
    end)
    |> List.flatten()
    |> Kernel.--([{x, y}])
  end

  use Memoize

  defmemo get_paper_rolls_coordinates(data) do
    data
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {char, x} ->
        {char, {x, y}}
      end)
    end)
    |> Enum.filter(fn {char, _} -> char == "@" end)
    |> Enum.map(fn {_, coordinates} -> coordinates end)
  end

  # helpers
  def fetch_data() do
    day = "4"
    Aoc.Utils.Api.get_input(day)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row |> String.split("", trim: true)
    end)
  end
end
