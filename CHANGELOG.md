### v0.0.1.alpha.2
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
