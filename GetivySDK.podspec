Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.4'
s.name = "GetivySDK"
s.summary = "Getivy SDK for iOS"
s.requires_arc = true

s.version = "1.0.1"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Simon Wimmer" => "simon.wimmer@getivy.de" }

s.homepage = "https://github.com/getivy/ios-sdk"

s.source = { :git => "https://github.com/getivy/ios-sdk.git", 
             :tag => "#{s.version}" }

s.framework = "UIKit"

s.source_files = "Source/**/*.{swift}"

s.resources = "Source/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,otf,lproj}"

s.swift_version = "5.7"

end
