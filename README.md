# Exoplanets

This gem requests data from the NASA Exoplanetary API.  It retrieves a hash of exoplanets within the chosen parsec range before rehashing into 
Host Star > Exoplanet format for use of use.  After displaying all known star systems within range, the CLI accepts an input of a specific star system or list number in order to display detailed information for the selection.  The program has full exit/restart/help functionality throughout.

## Installation

Add these lines to your application's Gemfile:

```ruby
gem "rake", "~> 12.0"
gem 'httparty', '~> 0.13.7'
gem 'json', '~> 1.8', '>= 1.8.3'
```

And then execute:

    $ bundle install

## Usage

Launch with:

    bin/run

Typical Progression:

    [1] Input distance value
    [2] Input name or list number
    [3] Input back/exit/restart


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/exoplanets. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/exoplanets/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Exoplanets project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/exoplanets/blob/master/CODE_OF_CONDUCT.md).
