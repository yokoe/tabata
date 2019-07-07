#
# Be sure to run `pod lib lint Tabata.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Tabata'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight CIFilter wrapper for Mac apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A lightweight CIFilter wrapper for Mac apps written in Swift.
Automatically skips filters which have no effect in specified params.
                       DESC

  s.homepage         = 'https://github.com/yokoe/tabata'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SotaYokoe' => 'info@kreuz45.com' }
  s.source           = { :git => 'https://github.com/yokoe/tabata.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kreuz45'

  s.osx.deployment_target = '10.10'

  s.source_files = 'Tabata/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'Tabata' => ['Tabata/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Cocoa'
  # s.dependency 'AFNetworking', '~> 2.3'
end
