defmodule Aoc.Day5Test do
  use ExUnit.Case

  alias Aoc.Day5, as: Subject

  # replace with test data from the AoC puzzle page
  @test_data """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  test "execute_part_1/1" do
    result = Subject.execute_part_1(@test_data)

    assert result == 3
  end

  test "execute_part_2/1" do
    result = Subject.execute_part_2(@test_data)

    assert result == 14
  end
end
