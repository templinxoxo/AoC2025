#!/bin/bash
day=$(date +'%-d')

echo lib/src/day$day/day_$day.test.exs
iex -S mix test lib/src/day$day/day_$day.test.exs