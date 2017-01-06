# SwiftCountryPicker

![Image](http://i.imgur.com/ZGjTtoX.png)

[![CI Status](http://img.shields.io/travis/Samuel Beek/SwiftCountryPicker.svg?style=flat)](https://travis-ci.org/Samuel Beek/SwiftCountryPicker)
[![Version](https://img.shields.io/cocoapods/v/SwiftCountryPicker.svg?style=flat)](http://cocoapods.org/pods/SwiftCountryPicker)
[![License](https://img.shields.io/cocoapods/l/SwiftCountryPicker.svg?style=flat)](http://cocoapods.org/pods/SwiftCountryPicker)
[![Platform](https://img.shields.io/cocoapods/p/SwiftCountryPicker.svg?style=flat)](http://cocoapods.org/pods/SwiftCountryPicker)



## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

**For the most clear example, checkout the example project**

Create a new CountryPicker 

```swift
let countryPicker = CountryPicker(frame: CGRectMake(0,0,self.view.frame.size.width, 216))
countryPicker.countryDelegate = self
```

To retreive the picked country the ViewController must conform with the `CountryPickerDelegate`, do that by adding the following snippet at the bottom of your file: 

```swift
func countryPicker(picker: CountryPicker, didSelectCountry country: Country) {
	// do whatever you want with the picked Counrty
}

```

To add the CountryPicker as inputView for a textField:

```swift
textField = UITextField(frame: CGRectMake(0,0,40,30))
textField.inputView = countryPicker
view.addSubview(textField)

```

## Requirements
iOS 9 or higher

## Installation

SwiftCountryPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftCountryPicker"
```

or install it with Carthage 
```ruby
github "samuelbeek/SwiftCountryPicker"
```


Add the following line to the top of the file you want to use the CountryPicker in:

```swift
import SwiftCountryPicker 
``` 


## Author

Samuel Beek, ik@samuelbeek.com, [twitter](http://twitter.com/samuelbeek)

## License

SwiftCountryPicker is available under the MIT license. See the LICENSE file for more info.
