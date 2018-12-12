Pod::Spec.new do |s|
    s.name         = "PlaceholderKit"
    s.version      = "0.0.1"
    s.summary      = "Create placeholder images. In Swift."
    s.homepage     = "https://github.com/simonlee2/PlaceholderKit"
    s.description  = ""
  
    s.license = { :type => "MIT", :file => "LICENSE.md" }
    s.authors = {
      "Simon Lee" => "dev.simonlee@gmail.com"
    }
  
    s.source = { :git => "https://github.com/simonlee2/PlaceholderKit", :tag => "0.0.1" }
    s.source_files = "Sources"
  
    s.platforms = { :ios => "8.0", :osx => "10.11", :tvos => "9.0", :watchos => "3.0" }
    s.swift_version = "4.2"
  end