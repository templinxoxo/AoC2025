defmodule Aoc.Day6Test do
  use ExUnit.Case

  alias Aoc.Day6, as: Subject

  # replace with test data from the AoC puzzle page
  @test_data """
  123 328  51 64 \n
   45 64  387 23 \n
    6 98  215 314
  *   +   *   +  \n
  """

  test "execute_part_1/1" do
    result = Subject.execute_part_1(@test_data)

    assert result == 4_277_556
  end

  test "execute_part_2/1" do
    result = Subject.execute_part_2(@test_data)

    assert result == 3_263_827
  end
end
