defmodule Aoc.Day2 do
  @moduledoc """
  Day 2 solutions
  https://adventofcode.com/2025/day/2
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input()
    |> Enum.map(&find_invalid_ids_1/1)
    |> List.flatten()
    |> Enum.sum()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input()
    |> Enum.map(&find_invalid_ids_2/1)
    |> List.flatten()
    |> Enum.sum()
  end

  def find_invalid_ids_1({first, last}), do: Enum.filter(first..last, &is_invalid_id_1?/1)
  def find_invalid_ids_2({first, last}), do: Enum.filter(first..last, &is_invalid_id_2?/1)

  def is_invalid_id_1?(id) when is_integer(id) do
    id = Integer.to_string(id)
    {first, last} = String.split_at(id, floor(String.length(id) / 2))

    first == last
  end

  def is_invalid_id_2?(id) when is_integer(id) do
    id = Integer.to_string(id)
    len = String.length(id)

    # edge case for len=1; hence ceil instead of floor
    1..ceil(len / 2)
    # only indices that divide the number into even chunks
    |> Enum.filter(&(rem(len, &1) == 0))
    # check if it's made from repeating parts
    |> Enum.any?(fn index ->
      id
      # chunk by index
      |> String.split("", trim: true)
      |> Enum.chunk_every(index)
      |> Enum.map(&Enum.join(&1, ""))
      |> then(fn chunks ->
        # check if all parts are same and there's at least one repetition
        length(chunks) > 1 and chunks |> Enum.uniq() |> length() == 1
      end)
    end)
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
