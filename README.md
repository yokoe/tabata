# Tabata

[![CI Status](http://img.shields.io/travis/SotaYokoe/Tabata.svg?style=flat)](https://travis-ci.org/SotaYokoe/Tabata)
[![Version](https://img.shields.io/cocoapods/v/Tabata.svg?style=flat)](http://cocoapods.org/pods/Tabata)
[![License](https://img.shields.io/cocoapods/l/Tabata.svg?style=flat)](http://cocoapods.org/pods/Tabata)
[![Platform](https://img.shields.io/cocoapods/p/Tabata.svg?style=flat)](http://cocoapods.org/pods/Tabata)

A lightweight CIFilter wrapper for Mac apps.

Used in: [Lapsodi](http://en.nantekottai.com/2016/05/25/lapsodi-time-lapse-stop-motion/) Time-Lapse app.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
let sourceImage = NSImage(...)
let image = Tabata()
                .brightness(brightness, saturation: saturation, andContrast: contrast)
                .hue(hue)
                .process(image: sourceImage) # returns NSImage.
```

## Filters
### Brightness, contrast and saturation
```
Tabata().brightness(brightness, saturation: saturation, andContrast: contrast)
```

### Exposure
```
Tabata().exposure(0.5)
```

### Hue
```
Tabata().hue(1.57)
```
### Gaussian blur

```
Tabata().gaussianBlur(10)
```
### Tilt-Shift
```
Tabata().tiltShift(4)
```

### Scale
```
Tabata().scale(0.5)
```

## Requirements

## Installation

Tabata is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Tabata"
```

## Author

SotaYokoe, info@kreuz45.com

## License

Tabata is available under the MIT license. See the LICENSE file for more info.
