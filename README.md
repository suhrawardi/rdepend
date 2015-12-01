# Ꝛdepend

Mind that this Gem is experimental, a work in progress. If you happen to
encounter bugs or like to discuss the output or it's use cases,
please open an issue in the issue tracker.

It generates a graph visualization of the dependencies in your codebase.

A lot of incoming links is good, as it is a sign of code re-use and DRY code.
A lot of outgoing links is bad, as that is a sign of a lot of dependencies.

See http://www.whiteboxtest.com/information-flow-metrics.php

## Installation

This Gem depends on Graphviz, http://www.graphviz.org/

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
  # your code
end
```

or

```ruby
Rdepend.trace
# your code
```

Don't even think about using this Gem in a production environment.
You can use it in your integration test suite for instance. But don't use it
in a test environment where you use stubs, mocks and doubles etc.

Oh, and it can take a very long time, even on a simple Rails project.

## Contributing

1. Fork it ( https://github.com/suhrawardi/rdepend/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
