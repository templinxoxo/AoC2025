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

    assert result == 6
  end

  describe "times_over_zero/2" do
    test "0: for move from 0 to -100  (full rotation left)" do
      assert Subject.times_over_zero(-100, 0) == 0
    end

    test "0: for move from 0 to -50  (rotation left over 0, but starting at 0)" do
      assert Subject.times_over_zero(-50, 0) == 0
    end

    test "0: for move from 1 to -50  (rotation left over 0, starting over 0)" do
      assert Subject.times_over_zero(-50, 1) == 1
    end

    test "0: for move from 0 to 100   (full rotation right)" do
      assert Subject.times_over_zero(100, 0) == 0
    end

    test "1: for move from 0 to -101  (above 1 full rotation left)" do
      assert Subject.times_over_zero(-101, 0) == 1
    end

    test "1: for move from 0 to 101   (above 1 full rotation right)" do
      assert Subject.times_over_zero(101, 0) == 1
    end

    test "0: for move from 40 to 60   (standard right rotation)" do
      assert Subject.times_over_zero(40, 60) == 0
    end

    test "0: for move from 60 to 40   (standard left rotation)" do
      assert Subject.times_over_zero(60, 40) == 0
    end

    test "2: for move from 10 to -210   (over 2 full left rotations)" do
      assert Subject.times_over_zero(-210, 10) == 3
    end

    test "1: for move from 0 to -210   (2 full left rotations, but starting at 0)" do
      assert Subject.times_over_zero(-210, 0) == 2
    end

    test "2: for move from 10 to 210   (2 full right rotations)" do
      assert Subject.times_over_zero(210, 10) == 2
    end

    test "2: for move from 0 to 210   (over 2 full right rotations)" do
      assert Subject.times_over_zero(210, 10) == 2
    end
  end
end
