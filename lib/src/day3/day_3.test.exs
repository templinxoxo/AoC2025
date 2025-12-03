defmodule Aoc.Day3Test do
  use ExUnit.Case

  alias Aoc.Day3, as: Subject

  # replace with test data from the AoC puzzle page
  @test_data """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  test "execute_part_1/1" do
    result = Subject.execute_part_1(@test_data)

    assert result == 357
  end

  test "execute_part_2/1" do
    result = Subject.execute_part_2(@test_data)

    assert result == 3_121_910_778_619
  end
end
