#
# Be sure to run `pod lib lint LeoPopScreen.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LeoPopScreen'
  s.version          = '0.1.0'
  s.summary          = 'LeoPopScreen is an easy way to show pop up on the screens with awesome customization'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  LeoPopScreen is an easy way to show pop up on the screens with awesome customization.
  
  Get Started with one line
  ```LeoPopScreen(on: self, delegate: self, dataSource: self)```
  
  you can customization properties with ```LeoPopScreenDataSource```
  
  you can get callback delegate with ```LeoPopSceenDelegate```
                       DESC

  s.homepage         = 'https://github.com/ranggaleoo/LeoPopScreen'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ranggaleoo' => 'leorangga30@ymail.com' }
  s.source           = { :git => 'https://github.com/ranggaleoo/LeoPopScreen.git', :tag => s.version.to_s }
  s.social_media_url = 'https://instagram.com/ranggaleoo'

  s.ios.deployment_target = '8.0'
  s.swift_versions = '5.0'
  
  s.source_files = 'LeoPopScreen/Classes/**/*'
  # s.source_files = 'LeoPopScreen/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'LeoPopScreen' => ['LeoPopScreen/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
