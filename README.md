# Chroma

[![Gem Version](https://badge.fury.io/rb/chroma.svg)](http://badge.fury.io/rb/chroma)
[![Build Status](https://travis-ci.org/jfairbank/chroma.svg?branch=master)](https://travis-ci.org/jfairbank/chroma)

Chroma is a color manipulation and palette generation library. It is heavily
inspired by and a very close Ruby port of the
[tinycolor.js](https://bgrins.github.io/TinyColor/)
library. Many thanks to [Brian Grinstead](http://www.briangrinstead.com/blog/)
for his hard work on that library.

Please don't hesitate to examine the code and make issues, feature requests,
or pull requests. Please refer to the [Contributing](#contributing) section
below.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chroma'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chroma

## Creating Colors

Colors are created via the `Chroma.paint` method. It expects any one of
many possible color formats as a string, including names, hexadecimal, rgb,
hsl, and hsv. As a convenience, a `String#paint` is also available for more
succinct color creation.

```ruby
# With Chroma.paint
Chroma.paint 'red'                       # named colors
Chroma.paint '#00ff00'                   # 6 character hexadecimal
Chroma.paint '#00f'                      # 3 character hexadecimal
Chroma.paint 'rgb(255, 255, 0)'          # rgb
Chroma.paint 'rgba(255, 255, 0, 0.5)'    # rgba
Chroma.paint 'hsl(60, 100%, 50%)'        # hsl with percentages
Chroma.paint 'hsl(60, 1, 0.5)'           # hsl with decimals
Chroma.paint 'hsla(60, 100%, 50%, 0.5)'  # hsla
Chroma.paint 'hsv(60, 100%, 50%)'        # hsv with percentages
Chroma.paint 'hsv(60, 1, 0.5)'           # hsv with decimals
Chroma.paint 'hsva(60, 100%, 50%, 0.75)' # hsva

# With String#paint
'red'.paint
'#00ff00'.paint
'#00f'.paint
'rgb(255, 255, 0)'.paint
'rgba(255, 255, 0, 0.5)'.paint
'hsl(60, 100%, 50%)'.paint
'hsla(60, 100%, 50%, 0.5)'.paint
'hsv(60, 100%, 50%)'.paint
'hsva(60, 100%, 50%. 0.5)'.paint
```

## Motivation

Chroma's major strength is manipulating colors and generating color palettes,
which allows you to easily generate dynamic colors, dynamic themes for a web
application, and more.

## Color Manipulation

#### Lighten

Lighten the color by a given amount. Defaults to 10.

```ruby
'red'.paint.lighten     #=> #ff3333
'red'.paint.lighten(20) #=> #ff6666
```

#### Brighten

Brighten the color by a given amount. Defaults to 10.

```ruby
'red'.paint.brighten     #=> #ff1a1a
'red'.paint.brighten(20) #=> #ff3333
```

#### Darken

Darken the color by a given amount. Defaults to 10.

```ruby
'red'.paint.darken     #=> #cc0000
'red'.paint.darken(20) #=> #990000
```

#### Desaturate

Desaturate the color by a given amount. Defaults to 10.

```ruby
'red'.paint.desaturate     #=> #f20d0d
'red'.paint.desaturate(20) #=> #e61919
```

#### Saturate

Saturate the color by a given amount. Defaults to 10.

```ruby
'#123'.paint.saturate     #=> #0e2236
'#123'.paint.saturate(20) #=> #0a223a
```

#### Grayscale

Convert the color to grayscale.

```ruby
'green'.paint.grayscale #=> #404040

# greyscale is an alias
'red'.paint.greyscale   #=> #808080
```

#### Opacity

Set the opacity of the color to a given amount.

```ruby
'red'.paint.opacity(0.3) #=> #ff0000
'red'.paint.opacity(0.3).to_rgb #=> 'rgba(255, 0, 0, 0.3)'
```

#### Spin

Spin a given amount in degrees around the hue wheel.

```ruby
'red'.paint.spin(30) #=> #ff8000
'red'.paint.spin(60) #=> yellow
'red'.paint.spin(90) #=> #80ff00
```

## Generating Palettes

Chroma's most powerful feature is palette generation. You can use the default
palettes available or even create your own custom palettes.

Palette methods are available via `Color#palette` and by default output an
array of colors. If you want the underlying color strings, you can pass in
the desired format via the `:as` option.

#### Available Formats

* name
* rgb
* hex
* hex6 (alias for hex)
* hex3
* hex8 (includes the alpha value in the highest order byte)
* hsl
* hsv

#### Complement

Generate a complement palette.

```ruby
'red'.paint.palette.complement            #=> [red, cyan]
'red'.paint.palette.complement(as: :name) #=> ['red', 'cyan']
'red'.paint.palette.complement(as: :hex)  #=> ['#ff0000', '#00ffff']
```

#### Triad

Generate a triad palette.

```ruby
'red'.paint.palette.triad            #=> [red, lime, blue]
'red'.paint.palette.triad(as: :name) #=> ['red', 'lime', 'blue']
'red'.paint.palette.triad(as: :hex)  #=> ['#ff0000', '#00ff00', '#0000ff']
```

#### Tetrad

Generate a tetrad palette.

```ruby
'red'.paint.palette.tetrad
#=> [red, #80ff00, cyan, #7f00ff]

'red'.paint.palette.tetrad(as: :name)
#=> ['red', '#80ff00', 'cyan', '#7f00ff']

'red'.paint.palette.tetrad(as: :hex)
#=> ['#ff0000', '#80ff00', '#00ffff', '#7f00ff']
```

#### Split Complement

Generate a split complement palette.

```ruby
'red'.paint.palette.split_complement
#=> [red, #ccff00, #0066ff]

'red'.paint.palette.split_complement(as: :name)
#=> ['red', '#ccff00', '#0066ff']

'red'.paint.palette.split_complement(as: :hex)
#=> ['#ff0000', '#ccff00', '#0066ff']
```

#### Analogous

Generate an analogous palette. Pass in a `:size` option to specify the size
of the palette (defaults to 6). Pass in a `:slice_by` option to specify the
angle size to slice into the hue wheel (defaults to 30 degrees).

```ruby
'red'.paint.palette.analogous
#=> [red, #ff0066, #ff0033, red, #ff3300, #ff6600]

'red'.paint.palette.analogous(as: :hex)
#=> ['#f00', '#f06', '#f03', '#f00', '#f30', '#f60']

'red'.paint.palette.analogous(size: 3)
#=> [red, #ff001a, #ff1a00]

'red'.paint.palette.analogous(size: 3, slice_by: 60)
#=> [red, #ff000d, #ff0d00]
```

#### Monochromatic

Generate a monochromatic palette. Pass in a `:size` option to specify the size
of the palette (defaults to 6).

```ruby
'red'.paint.palette.monochromatic
#=> [red, #2a0000, #550000, maroon, #aa0000, #d40000]

'red'.paint.palette.monochromatic(as: :hex)
#=> ['#ff0000', '#2a0000', '#550000', '#800000', '#aa0000', '#d40000']

'red'.paint.palette.monochromatic(size: 3)
#=> [red, #550000, #aa0000]
```

## Defining Custom Palettes

Chroma allows you to define your own custom palettes if the default ones aren't
all you're looking for. You can define a custom palette by calling
`Chroma.define_palette`, passing in a palette name and definition block. The
definition block uses the color manipulation methods (i.e. `lighten`, `spin`,
etc.) as its DSL. Every DSL call defines a new color that will be included
in the palette. Your seed color (i.e. the color from which you call the
palette method) will be included as the first color in your palette too.

```ruby
red = 'red'.paint

red.palette.respond_to? :my_palette #=> false

# Define a palette with 5 colors including the seed color
Chroma.define_palette :my_palette do
  spin 60
  spin 180
  spin(60).brighten(20) # chain calls as well
  greyscale
end

red.palette.respond_to? :my_palette #=> true

red.palette.my_palette #=> [#ff0000 #ffff00 #00ffff #ffff33 #808080]
```

## Dynamic Custom Palettes

You can generate custom palettes on the fly too with
`Chroma::Color#custom_palette`.

```ruby
'red'.paint.custom_palette do
  spin 60
  spin 180
end

#=> [red, yellow, cyan]
```

## Serializing Colors

Colors offer several methods to output to different string color [formats](#available-formats).

| Method    | Description                                                                                                      |
| --------- | ---------------------------------------------------------------------------------------------------------------- |
| `to_hsv`  | output to hsv string, outputs hsva if alpha < 1                                                                  |
| `to_hsl`  | output to hsl string, outputs hsla if alpha < 1                                                                  |
| `to_hex`  | output to hex string, optional argument allows 3-character hex output if possible                                |
| `to_hex8` | output to 8-character hex string with alpha value in the highest order byte                                      |
| `to_rgb`  | output to rgb string, outputs rgba if alpha < 1                                                                  |
| `to_name` | output to color name string if available, otherwise `'<unknown>'` or `to_hex` output based on optional arg value |
| `to_s`    | output to the appropriate string format based on how the color was created, optional arg forces the format       |

```ruby
# to_hsv
'red'.paint.to_hsv                  #=> 'hsv(0, 100%, 100%)'
'rgba(255, 0, 0, 0.5)'.paint.to_hsv #=> 'hsva(0, 100%, 100%, 0.5)'

# to_hsl
'red'.paint.to_hsl                  #=> 'hsl(0, 100%, 50%)'
'rgba(255, 0, 0, 0.5)'.paint.to_hsl #=> 'hsla(0, 100%, 50%, 0.5)'

# to_hex
'red'.paint.to_hex                  #=> '#ff0000'
'red'.paint.to_hex(true)            #=> '#f00'
'rgba(255, 0, 0, 0.5)'.paint.to_hex #=> '#ff0000'
'red'.paint.to_hex                  #=> '#ffff0000'
'rgba(255, 0, 0, 0.5)'.paint.to_hex #=> '#80ff0000'

# to_rgb
'red'.paint.to_rgb                  #=> 'rgb(255, 0, 0)'
'rgba(255, 0, 0, 0.5)'.paint.to_rgb #=> 'rgb(255, 0, 0, 0.5)'

# to_name
'red'.paint.to_name                  #=> 'red'
'#00f'.paint.to_name                 #=> 'blue'
'rgba(255, 0, 0, 0.5)'.paint.to_name #=> '<unknown>'
'#123'.paint.to_name(true)           #=> '#112233'

# to_s
'red'.paint.to_s             #=> 'red'
'rgb(255, 0, 0)'.paint.to_s  #=> 'rgb(255, 0, 0)'
'#f00'.paint.to_s            #=> '#f00'
'#80ff0000'.paint.to_s(:rgb) #=> 'rgba(255, 0, 0, 0.5)'
```

## Other Methods

Colors also have a few other helper methods:

| Method       | Description                                            |
| ------------ | ------------------------------------------------------ |
| `dark?`      | is the color dark?                                     |
| `light?`     | is the color light?                                    |
| `alpha`      | retrieve the alpha value                               |
| `brightness` | calculate the brightness as a number between 0 and 255 |
| `complement` | return the complementary color                         |

```ruby
# dark?
'red'.paint.dark?    #=> true
'yellow'.paint.dark? #=> false

# light?
'red'.paint.light?    #=> false
'yellow'.paint.light? #=> true

# alpha
'red'.paint.alpha                #=> 1.0
'rgba(0, 0, 0, 0.5)'.paint.alpha #=> 0.5

# brightness
'red'.paint.brightness    #=> 76.245
'yellow'.paint.brightness #=> 225.93
'white'.paint.brightness  #=> 255.0
'black'.paint.brightness  #=> 0.0

# complement
'red'.paint.complement #=> cyan
```

## Contributing

Please branch from **dev** for all pull requests.

1. Fork it (https://github.com/jfairbank/chroma/fork)
2. Checkout dev (`git checkout dev`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new pull request against dev
