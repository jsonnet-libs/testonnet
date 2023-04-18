local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';
local xtd = import 'github.com/jsonnet-libs/xtd/main.libsonnet';

{
  '#new':: d.fn(
    help=|||
      `new` can define a custom expect method to use in a test suite

      ```
      local equalSet = test.expect.new(
        satisfy=function(actual, expected)
          std.set(actual) == std.set(expected),
        message=function(actual, expected)
          'Expected ' + actual + ' to be equal to ' + expected + ' as a set',
      );

      test.new('custom')
      + test.case.new(
        name='Equal Set',
        test=equalSet([6, 7, 2, 3, 7], [2, 3, 6, 7])
      )
      ```

      Arguments:
      * `satisfy`: (function(actual, expected) boolean)
          Returns boolean if `actual` satisfies `expected`.
      * `message`: (fuction(actual, expected) string)
          Returns error message `actual` satisfies `expected`.
    |||,
    args=[
      d.arg('satisfy', d.T.func),
      d.arg('message', d.T.func),
    ],
  ),
  new(satisfy, message):
    function(actual, expected) {
      verify: satisfy(actual, expected),
      message: message(actual, expected),
    },

  local docstring(name, help) = d.fn(
    help=|||
      `%s` test for %s

      Arguments:
      * `actual`: (any) The actual value.
      * `expected`: (any) The expected value to satisfy this test.
    ||| % [name, help],
    args=[
      d.arg('actual', d.T.any),
      d.arg('expected', d.T.any),
    ],
  ),

  '#eq':: docstring('eq', 'value equality'),
  eq: self.new(
    function(actual, expected) actual == expected,
    function(actual, expected)
      'Expected ' + actual + ' to be ' + expected,
  ),

  '#eqJson':: docstring('eqJson', 'JSON object equality with pretty print'),
  eqJson: self.new(
    function(actual, expected) actual == expected,
    function(actual, expected)
      '\nActual:\n'
      + std.manifestJson(actual)
      + '\nExpected:\n'
      + std.manifestJson(expected),
  ),

  '#eqDiff':: docstring('eqDiff', 'value equality with JSON diff-like output'),
  eqDiff: self.new(
    function(actual, expected) actual == expected,
    function(actual, expected)
      '\nThe diff between expected and actual:\n'
      + std.manifestJson(xtd.inspect.diff(expected, actual))
  ),


  '#neq':: docstring('neq', 'value inequality'),
  neq: self.new(
    function(actual, expected) actual != expected,
    function(actual, expected)
      'Expected ' + actual + ' not to be ' + expected,
  ),

  '#lt':: docstring('lt', 'if `actual` is less than `expected`'),
  lt: self.new(
    function(actual, expected) actual < expected,
    function(actual, expected)
      'Expected ' + actual + ' to be less than ' + expected,
  ),

  '#le':: docstring('le', 'if `actual` is less than or equal to `expected`'),
  le: self.new(
    function(actual, expected) actual <= expected,
    function(actual, expected)
      'Expected ' + actual + ' to be less than or equal to ' + expected,
  ),

  '#gt':: docstring('gt', 'if `actual` is greater than `expected`'),
  gt: self.new(
    function(actual, expected) actual > expected,
    function(actual, expected)
      'Expected ' + actual + ' to be greater than ' + expected,
  ),

  '#ge':: docstring('ge', 'if `actual` is greater than or equal to `expected`'),
  ge: self.new(
    function(actual, expected) actual >= expected,
    function(actual, expected)
      'Expected ' + actual + ' to be greater than or equal to ' + expected,
  ),
}
