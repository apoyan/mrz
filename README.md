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

### Generate

```ruby
params = {
  country: 'GBP',
  first_name: 'Anthony',
  middle_name: 'Vincent',
  last_name: 'Laibe',
  document_number: '9881234',
  nationality: 'UK',
  birth_date: Date.new(1889, 12, 10),
  gender: 'm',
  expire_date: Date.new(2021, 5, 4),
  personal_code: '1234',
}

Mrz::Builder.new(params).generate
```

### Parse

```
id_card = [
    "IDD<<T220001293<<<<<<<<<<<<<<<",
    "6408125<2010315D<<<<<<<<<<<<<4",
    "MUSTERMANN<<ERIKA<PAULA<ANNA<<"
]

result = MRZ.parse(id_card)

result.valid?                      # => true
result.valid_birth_date?	   # => true
result.valid_expiration_date?      # => true
result.valid_document_number?      # => true
result.birth_date                  # => Date.new(1964, 8, 12)
result.birth_date_check_digit      # => "5"
result.composite_check_digit       # => "4"
result.document_code               # => "ID"
result.document_number             # => "T22000129"
result.document_check_digit        # => "3"
result.expiration_date             # => Date.new(2020, 10, 15)
result.expiration_date_check_digit # => "5"
result.first_name                  # => "ERIKA PAULA ANNA"
result.issuing_state               # => "D"
result.last_name                   # => "MUSTERMANN"
result.nationality                 # => "D"
result.optional1                   # => ""
result.optional2                   # => ""
result.sex                         # => "nonspecified" (otherwise "M" or "F")
```


For gender the allowed values are 'm' or 'f'
The personal number is an optional parameter
This method return an array of size 2, each entry correspond to a line of the MRZ
