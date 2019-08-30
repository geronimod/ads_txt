# Ads.txt

Authorized Digital Sellers parser following the [IAB](https://iabtechlab.com/ads-txt/) specification.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ads_txt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ads_txt

## Usage

Parsing valid content:
```
content =<<-ADSTXT
# some comment
silverssp.com, ABE679, RESELLER, d75815a79
var=assignment
ADSTXT

parser = AdsTxt::Parser.new(content)
parser.valid? # => true
parser.variables # => { "var" =>  "assignment" }
parser.data_records # => [{ "domain_name" => "silverssp.com", "publisher_account_id" => "ABE679", "account_type" => "RESELLER", "certificate_authority_id" => "d75815a79" }]
```

Parsing invalid content:
```
content =<<-ADSTXT
# some comment
silverssp.com, ABE679, RESELLER, d75815a79
-a, odd, RESELLER, adsf
123
ADSTXT

parser = AdsTxt::Parser.new(content)
parser.valid? # => false
parser.errors # => ["-a, odd, RESELLER, adsf", "123"]
```

## Contributing

1. Fork it ( https://github.com/geronimod/ads_txt/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
