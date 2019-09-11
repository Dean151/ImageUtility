Pod::Spec.new do |spec|

  spec.name         = "ImageUtility"
  spec.version      = "0.3.5"
  spec.summary      = "Helpers functions performing image operations for iOS."

  spec.description  = <<-DESC
  Utilities function for UIImage : Scale, Colors, ... and many more to come!
                   DESC

  spec.homepage     = "https://github.com/Dean151/ImageUtility"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Thomas Durand" => "contact@thomasdurand.fr" }
  spec.social_media_url   = "https://twitter.com/deanatoire"

  spec.platform     = :ios, "8.0"

  spec.swift_version = '5.0'

  spec.source       = { :git => "https://github.com/Dean151/ImageUtility.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/ImageUtility/*.swift"

end
