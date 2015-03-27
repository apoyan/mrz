# MRZ

Generate your passport machine readable zone

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mrz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mrz

## Usage

```ruby
params = {
  type:,
  country:,
  first_name:,
  middle_name:,
  last_name:, 
  passport_number:, 
  nationality:,
  date_of_birth:, 
  gender:, 
  expiration_date:, 
  personal_number:, 
  code:
}

Mrz::Builder.new(params).generate
```

This method return array of size 2, each entry correspond to a line of the MRZ

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mrz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
