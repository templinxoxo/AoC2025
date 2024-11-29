
# make a new directory for each day
for day in $(seq 1 12);
do
  mkdir lib/src/day$day
  # copy templates
  cp lib/template/day_X.md          lib/src/day$day/day_$day.ex
  cp lib/template/day_X.test.md    lib/src/day$day/day_$day.test.exs

  # replace placeholder day value with the actual day
  placeholder='__DAY__'
  sed -i -e "s/$placeholder/$day/g" lib/src/day$day/day_$day.ex
  sed -i -e "s/$placeholder/$day/g" lib/src/day$day/day_$day.test.exs

  echo "Day $day initialized"
done