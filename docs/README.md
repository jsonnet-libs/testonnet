# package testonnet

Testonnet is a unit test framework for [Jsonnet](http://jsonnet.org/).


## Install

```
jb install github.com/jsonnet-libs/testonnet@master
```

## Usage

```jsonnet
local test = import "github.com/jsonnet-libs/testonnet/main.libsonnet";

local fact(n) = if n == 0 then 1 else n * fact(n - 1);

test.new(std.thisFile)
+ test.case.new(
  name='Fact',
  test=test.expect.eq(
    actual=fact(10),
    expected=3628800
  )
)

```

## Index

* [`fn new(name)`](#fn-new)
* [`obj case`](#obj-case)
  * [`fn new(name, test)`](#fn-casenew)
* [`obj expect`](#obj-expect)
  * [`fn eq(actual, expected)`](#fn-expecteq)
  * [`fn eqDiff(actual, expected)`](#fn-expecteqdiff)
  * [`fn eqJson(actual, expected)`](#fn-expecteqjson)
  * [`fn ge(actual, expected)`](#fn-expectge)
  * [`fn gt(actual, expected)`](#fn-expectgt)
  * [`fn le(actual, expected)`](#fn-expectle)
  * [`fn lt(actual, expected)`](#fn-expectlt)
  * [`fn neq(actual, expected)`](#fn-expectneq)
  * [`fn new(satisfy, message)`](#fn-expectnew)

## Fields

### fn new

```ts
new(name)
```

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


### obj case


#### fn case.new

```ts
new(name, test)
```

`new` creates a new test case.


### obj expect


#### fn expect.eq

```ts
eq(actual, expected)
```

`eq` test for value equality

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.eqDiff

```ts
eqDiff(actual, expected)
```

`eqDiff` test for value equality with JSON diff-like output

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.eqJson

```ts
eqJson(actual, expected)
```

`eqJson` test for JSON object equality with pretty print

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.ge

```ts
ge(actual, expected)
```

`ge` test for if `actual` is greater than or equal to `expected`

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.gt

```ts
gt(actual, expected)
```

`gt` test for if `actual` is greater than `expected`

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.le

```ts
le(actual, expected)
```

`le` test for if `actual` is less than or equal to `expected`

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.lt

```ts
lt(actual, expected)
```

`lt` test for if `actual` is less than `expected`

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.neq

```ts
neq(actual, expected)
```

`neq` test for value inequality

Arguments:
* `actual`: (any) The actual value.
* `expected`: (any) The expected value to satisfy this test.


#### fn expect.new

```ts
new(satisfy, message)
```

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

