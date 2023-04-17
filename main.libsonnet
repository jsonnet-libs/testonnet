local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  '#':
    d.pkg(
      name='testonnet',
      url='github.com/jsonnet-libs/testonnet',
      filename=std.thisFile,
      help=|||
        Testonnet is a unit test framework for [Jsonnet](http://jsonnet.org/).
      |||,
    )
    + d.package.withUsageTemplate(|||
      local test = import "%(import)s";

      local fact(n) = if n == 0 then 1 else n * fact(n - 1);

      test.new(std.thisFile)
      + test.case.new(
        name='Fact',
        test=test.expect.eq(
          actual=fact(10),
          expected=3628800
        )
      )
    |||),

  '#new': d.fn(
    help=|||
      `new` initializes Testonnet with a new test suite with a `name`.

      The `name` will be reported during execution, in case of failures it will help find
      the culprit, using `std.thisFile` in the name might be useful to identify the test
      suite.

      Output on success:

      ```
      $ jsonnet -J vendor/ test.jsonnet
      TRACE: testonnet/main.libsonnet:74 Testing suite test.jsonnet
      {
         "verify": "Passed 3 test cases"
      }
      ```

      Output on failure:
      ```
      $ jsonnet -J vendor/ test.jsonnet
      TRACE: testonnet/main.libsonnet:74 Testing suite test.jsonnet
      RUNTIME ERROR: Failed 3/3 test cases:
      testFoo: Expected 1 to be 2
      testBar: Expected 1 to satisfy the function
      testBaz: Expected 1 to satisfy the condition that the value is between 2 and 3
            testonnet/main.libsonnet:(78:11)-(84:13)	thunk from <object <anonymous>>
            testonnet/main.libsonnet:(74:7)-(87:8)	object <anonymous>
            Field "verify"
            During manifestation
      ```
    |||,
    args=[
      d.arg('name', d.T.string),
    ],
  ),
  new(name): {
    cases:: [],

    verify:
      local failures = [
        case
        for case in self.cases
        if !case.test.verify
      ];

      std.trace(
        'Testing suite ' + name,
        if std.length(failures) > 0
        then
          error 'Failed %d/%d test cases:\n' % [
            std.length(failures),
            std.length(self.cases),
          ] + std.join('\n', [
            '%s: %s' % [f.name, f.test.message]
            for f in failures
          ])
        else
          'Passed %d test cases' % std.length(self.cases),
      ),
  },

  case: {
    '#new':: d.fn(
      help=|||
        `new` creates a new test case.
      |||,

      args=[
        d.arg('name', d.T.string),
        d.arg('test', d.T.object),
      ]
    ),
    new(name, test): {
      cases+: [{
        name: name,
        test: test,
      }],
    },
  },

  expect: import 'expect.libsonnet',
}
