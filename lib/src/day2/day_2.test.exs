defmodule Aoc.Day2Test do
  use ExUnit.Case

  alias Aoc.Day2, as: Subject

  @test_data "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

  describe "execute_part_1/1" do
    test "example data" do
      result = Subject.execute_part_1(@test_data)

      assert result == 1_227_775_554
    end

    test "real data" do
      result = Subject.execute_part_1()

      assert result == 28_844_599_675
    end
  end

  test "execute_part_2/1" do
    result = Subject.execute_part_2(@test_data)

    assert result == 0
  end
end
