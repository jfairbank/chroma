# Chroma

[![Gem Version](https://badge.fury.io/rb/chroma.svg)](http://badge.fury.io/rb/chroma)
[![Build Status](https://travis-ci.org/jfairbank/chroma.svg?branch=master)](https://travis-ci.org/jfairbank/chroma)

Chroma is a color manipulation and palette generation library. It is heavily
inspired by and a very close Ruby port of the
[tinycolor.js](https://bgrins.github.io/TinyColor/)
library. Many thanks to [Brian Grinstead](http://www.briangrinstead.com/blog/)
for his hard work on that library.

Chroma is in alpha stage at the moment. Most of the API methods from tinycolor
have been ported over with a few exceptions. However, I will be working on
cleaning up the API where needed, adding docs and examples, and adding tests
before a first release. Because this is currently in alpha, please be
prepared for possible API changes or bugs.

Please don't hesitate to examine the code and make issues or pull requests
where you feel it is necessary. Please refer to the
[Contributing](#contributing) section below.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chroma', '0.0.1.alpha.3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chroma --pre

## Usage

Chroma adds several of the methods available in
[tinycolor.js](https://github.com/bgrins/TinyColor) but renamed appropriately
for Ruby conventions (i.e. `isDark` becomes `dark?`).

To create a color, just call the `Chroma.paint` method, passing in a string
that represents a color.

```ruby
Chroma.paint 'red'                    # named colors
Chroma.paint '#00ff00'                # 6 character hexadecimal
Chroma.paint '#00f'                   # 3 character hexadecimal
Chroma.paint 'rgb(255, 255, 0)'       # rgb
Chroma.paint 'rgba(255, 255, 0, 0.5)' # rgba
Chroma.paint 'hsl(60, 100%, 50%)'     # hsl with percentages
Chroma.paint 'hsl(60, 1, 0.5)'        # hsl with decimals
Chroma.paint 'hsv(60, 100%, 50%)'     # hsv with percentages
Chroma.paint 'hsv(60, 1, 0.5)'        # hsv with decimals
```

To work directly from a string you can also use the `String#paint` method:

```ruby
'red'.paint
'#00f'.paint
'rgb(255, 255, 0)'.paint

# etc...
```

## Contributing

Please branch from **dev** for all pull requests.

1. Fork it (https://github.com/jfairbank/chroma/fork)
2. Checkout dev (`git checkout dev`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new pull request against dev
