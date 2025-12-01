defmodule Aoc.Day1Test do
  use ExUnit.Case

  alias Aoc.Day1, as: Subject

  @test_data """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82

  """

  test "execute_part_1/1" do
    result = Subject.execute_part_1(@test_data)

    assert result == 3
  end

  test "execute_part_2/1" do
    result = Subject.execute_part_2(@test_data)

    assert result == 0
  end
end
