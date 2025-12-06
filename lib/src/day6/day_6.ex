defmodule Aoc.Day6 do
  @moduledoc """
  Day 6 solutions
  https://adventofcode.com/2025/day/6
  """
  def execute_part_1(data \\ fetch_data()) do
    data
    |> parse_input_1()
    |> Enum.map(&solve/1)
    |> Enum.sum()
  end

  def execute_part_2(data \\ fetch_data()) do
    data
    |> parse_input_2()
    |> Enum.map(&solve/1)
    |> Enum.sum()
  end

  def solve(task) do
    {numbers, [operation]} = Enum.split_while(task, &is_integer/1)

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

  def parse_input_1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row |> String.split(" ", trim: true) |> Enum.reject(&(&1 == "")) |> Enum.map(&parse/1)
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def parse_input_2(input) do
    rows = String.split(input, "\n", trim: true)
    operations = List.last(rows)

    ranges =
      # looking at the operations row
      operations
      |> String.split("")
      # find indices where each column with operation/numbers start
      |> Enum.with_index()
      |> Enum.filter(fn {operation, _index} ->
        operation in ["*", "+"]
      end)
      |> Enum.map(&elem(&1, 1))
      # map to column ranges
      |> Enum.chunk_every(2, 1)
      |> Enum.map(fn
        [from, to] -> {from - 1, to - 3}
        [from] -> {from - 1, -1}
      end)

      # then for each row
    rows
    |> Enum.map(fn row ->
      # split into columns by calculated ranges
      Enum.map(ranges, fn {from, to} ->
        String.slice(row, from..to//1)
      end)
    end)
    # zip to get columns in rows
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn row ->
      # clean up operations to atom value
      operation = List.last(row) |> String.trim() |> parse()

      # for numbers, transform based on cephalopod logic
      Enum.slice(row, 0..-2//1)
      |> transform()
      # concat operation to the end
      |> Enum.concat([operation])
    end)
  end

  def parse("*"), do: :multiply
  def parse("+"), do: :add
  def parse(number), do: String.to_integer(number)

  def transform(numbers) do
    iterations = numbers |> Enum.map(&String.length/1) |> Enum.max()

    1..iterations
    |> Enum.map(fn i ->
      numbers
      |> Enum.map(&String.at(&1, -i))
      |> Enum.reject(&(&1 == " "))
      |> Enum.join("")
      |> String.to_integer()
    end)
  end
end
