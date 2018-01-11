## quick_class

Install it with `gem install quick_class` or `gem 'quick_class'` - you know the drill.

Usage:

First default a class and call `attributes=`:

```
require 'quick_class'

class Foo < QuickClass
  self.attributes = { a: 0, b: 1 }
end

print Foo.attributes
# => {:a=>0, :b=>1}
```

`initialize` is generated and converted any passed arguments to instance variables.
The instance variables are accessible through generator `attr_accessor` functions.

```
Foo.new
# => #<Foo:0x007ff5e8a70d10>

foo = Foo.new a: 2
# => #<Foo:0x007ff5e8a70d10 @a=2>

foo.a
# => 2

foo.a = 3
# => 3
```

The `default` method is also defined, which is the same as passing `attributes` to `initialize`:

```
Foo.default
# => #<Foo:0x007fef7398f6b0 @a=0, @b=1>
```

It works with interitance also:

```
class Bar < Foo
  self.attributes = { c: 2 }
end

Bar.default
# => <Bar:0x007f9868906b60 @a=0, @b=1, @c=2>
```

Internally, the `attributes=` method is dynamically generating `attr_accessor` and `default` functions.

It can be called multiple times, and these methods will correctly update:

```
class Foo < QuickClass
  self.attributes = { a: 0 }
end

Foo.default.a
# => 0

Foo.attributes = { b: 1 }

Foo.default.a
# => NoMethodError

Foo.default.b
# => 1
```

The whole source code is 12 un-minified lines without comments.

use at own risk
