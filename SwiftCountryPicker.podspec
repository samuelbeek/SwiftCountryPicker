#
# Be sure to run `pod lib lint SwiftCountryPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SwiftCountryPicker"
  s.version          = "0.1.0"
  s.summary          = "A country picker that uses EMOJI as flags in Swift."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
    A subclass UIPicker 

                       DESC

  s.homepage         = "https://github.com/samuelbeek/SwiftCountryPicker"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
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

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
