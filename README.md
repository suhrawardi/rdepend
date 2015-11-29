# Ꝛdepend

Mind that this Gem is very experimental, a work in progress

It generates a graph visualization of the dependencies in your codebase.

A lot of incoming links are good, as that means that a function/module is
re-used a lot.
A lot of outgoing links a bad, as that means that that part of the code has
a lot of dependencies.

See also http://www.whiteboxtest.com/information-flow-metrics.php

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rdepend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rdepend

## Usage

```ruby
Rdepend.with_trace do
  @een = Een.new
  @een.start
end
```

```ruby
Rdepend.trace
@een = Een.new
@een.start
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rdepend/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
