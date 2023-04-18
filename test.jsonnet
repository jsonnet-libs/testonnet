local test = import 'main.libsonnet';
local fact(n) = if n == 0 then 1 else n * fact(n - 1);

test.new(std.thisFile)
+ test.case.new(
  name='Fact',
  test=test.expect.eq(
    actual=fact(10),
    expected=362880
    // Correct value:
    //expected=3628800
  )
)
+ test.case.new(
  name='Diff',
  test=test.expect.eqDiff(
    actual={
      same: 'same',
      change: 'this',
      remove: 'removed',
    },
    expected={
      same: 'same',
      change: 'changed',
      add: 'added',
    }
  )
)
