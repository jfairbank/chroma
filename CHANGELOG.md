## v0.2.0

### NEW `.opacity` Method

Added an `.opacity` method to set the opacity of a color. (credit [@matildasmeds](https://github.com/matildasmeds))

```ruby
'red'.paint.opacity(0.3).to_rgb #=> 'rgba(255, 0, 0, 0.3)'
```

---

## v0.1.0 - 2016-05-26

### Dynamic Custom Palettes

You can generate custom palettes on the fly without predefining them now. The
old way of defining them with a name via `Chroma.define_palette` still works
too.

```ruby
# New dynamic way
'red'.paint.custom_palette do
  spin 60
  spin 180
end

#=> [red, yellow, cyan]
```

## v0.0.1 - 2015-01-14

**Method Changes:**

* Renamed options for analogous palette method.
  * `:results` -> `:size`
  * `:slices` -> `:slice_by`
* Renamed option for monochromatic palette method.
  * `:results` -> `:size`

**Miscellaneous Changes:**

* Add remaining specs for public API.
* Add "transparent" as color name for `Chroma.paint`.
* Minor API doc example fixes.
* Add public API usage examples to README.

## [v0.0.1.alpha.3] - 2015-01-13

**Bug Fixes:**

* Fix bug where `Color#complement` didn't return a color of the same format.
* Fix bug where palettes did not have the same format as the seed color. (#16)
* Fix bug where the helper method `bound01` was not always producing accurate
  results for percentages due to integer division.
* Fix bug where a `Color` created from an rgba string
  (e.g. `'rgba(255, 0, 0, 0.5).paint'`) was not serializing to an rgba string
  from `to_s`. (#17)

**Method Changes:**

* Add `Color#format` method to return `@format` instance variable.
* Change arguments for `analogous` and `monochromatic` to option arguments.
* Add ability to output palette as an array of color format strings via the
  `:as` option. (#10)
* On `Color` rename `greyscale` to `grayscale` and alias `greyscale` back
  to `grayscale`.

**Miscellaneous Changes:**

* Introduced custom errors and replaced `raise` calls with them.
* Added API doc headers. (#4)

## [v0.0.1.alpha.2] - 2015-01-13

**Bug Fixes:**

* Fixed bug with number of arguments passed to generator classes in RgbGenerator. (#1)
* Make `FromHexStringValues.from_hex8` take alpha as second parameter instead of last.
  Fixes incorrect color generation from hex8. (#6)
* Ensure that string serialization rounds the alpha value where applicable. (#7)
* Fix bug where `to_s` and `inspect` would return `<unknown>` instead of using
  hex if the format was `:name` and the named color could not be found. (#2)
* Fix bug where `Color` equality wasn't implemented. (#12)
* Fix bug where passing in an instance of `Hsl` or `Hsv` to `Color.new` caused
  their values to get changed. (#11)
* Fix bug with `Color` equality being off due to floating point math. (#13)
* Fix bug where `Color` instances generated from hsla and hsva strings had the
  wrong alpha value. (#15)

**Method Changes:**

* Add optional `hex_for_unknown` parameter to `Color::Serializers#to_name`.
  If true, it allows `to_name` to default to hex string if name is not found
  instead of returning `'<unknown>'`. (#2)
* Add missing conversion methods to converters (a12244f0d81c9480490cfb8a472993f54dd9fbd2)
* Add equality (`eql?` and `==`) methods to `Color` class and `ColorModes`
  classes. (#12, #13)
* Add `Chroma.define_palette` for defining custom palettes. (#9)
* Add `Color#paint` method for returning itself. (#14)
* Tweak `Color` serialization method names. Switched to this naming primarily
  to drop the `*_s` on the string serialization methods.
  * `to_hsv`    -> `hsv`
  * `to_hsv_s`  -> `to_hsv`
  * `to_hsl`    -> `hsl`
  * `to_hsl_s`  -> `to_hsl`
  * `to_hex`    -> `to_basic_hex` (made private)
  * `to_hex_s`  -> `to_hex`
  * `to_hex8`   -> `to_basic_hex8` (made private)
  * `to_hex8_s` -> `to_hex8`
  * `to_rgb`    -> `rgb` (moved attr_reader to serializers and made public)
  * `to_rgb_s`  -> `to_rgb`
  * Removed `to_name_s` alias

## [v0.0.1.alpha.1] - 2015-01-11

* Initial release
