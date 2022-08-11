# Testonnet

A unit test framework for Jsonnet. This library is inspired by
[jsonnetunit](https://github.com/yugui/jsonnetunit), it follows the object-oriented
approach.

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

More docs in [docs/README.md](docs/README.md).
