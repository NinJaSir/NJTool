#
# Be sure to run `pod lib lint NJTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NJTool'
  s.version          = '0.3.0'
  s.summary          = 'A short description of NJTool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/NinJaSir/NJTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NinJa' => '625379797@qq.com' }
  s.source           = { :git => 'https://github.com/NinJaSir/NJTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'NJTool/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NJTool' => ['NJTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
#   s.frameworks = 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
