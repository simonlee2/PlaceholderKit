Pod::Spec.new do |s|
    s.name         = "PlaceholderKit"
    s.version      = "0.0.4"
    s.summary      = "Create placeholder images. In Swift."
    s.homepage     = "https://github.com/simonlee2/PlaceholderKit"
    s.description  = "PlaceholderKit generates images that you can use for testing during development."
  
    s.license = { :type => "MIT", :file => "LICENSE.md" }
    s.authors = {
      "Simon Lee" => "dev.simonlee@gmail.com"
    }
  
    s.source = { :git => "https://github.com/simonlee2/PlaceholderKit.git", :tag => s.version.to_s }
    s.source_files = "Sources/PlaceholderKit/"
    s.exclude_files = "Sources/**/*.plist"
  
    s.platforms = { :ios => "10.0", :osx => "10.13"}
    s.swift_version = "4.2"
  end
