Pod::Spec.new do |s|
  s.name             = "SwiftCountryPicker"
  s.version          = "1.0.0"
  s.summary          = "A country picker that uses EMOJI as flags in Swift."
  s.description      = <<-DESC
    A very simple CountryPicker in Swift, which is super easy to implement. It uses emoji as flags, so it's size is as low as possible. When a user has selected a country you can retreieve it's name and flag, but most importantly: it's ISO code. It's a subclass UIPickerView that displays country names and flags in a slot machine interface. Customization is very easy, because it's a UIPickerView suvlcass.
	description
	DESC
  s.homepage         = "https://github.com/samuelbeek/SwiftCountryPicker"
  s.screenshots     = "http://i.imgur.com/ZGjTtoX.png"
  s.license          = 'MIT'
  s.author           = { "Samuel Beek" => "ik@samuelbeek.com" }
  s.source           = { :git => "https://github.com/samuelbeek/SwiftCountryPicker.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/samuelbeek'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SwiftCountryPicker' => ['Pod/Assets/*.json']
  }
  s.frameworks = 'UIKit'
end
