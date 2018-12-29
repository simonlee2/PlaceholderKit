# PlaceholderKit

[![Build Status](https://travis-ci.com/simonlee2/PlaceholderKit.svg?branch=master)](https://travis-ci.com/simonlee2/PlaceholderKit) [![codecov](https://codecov.io/gh/simonlee2/PlaceholderKit/branch/master/graph/badge.svg)](https://codecov.io/gh/simonlee2/PlaceholderKit)


## Features

- Generate placeholder UIImages
- Import images to cameral roll

## Why do I need it?

There's a lot more to calculating diffs than performing table view animations easily!

Wherever you have code that propagates `added`/`removed`/`moved` callbacks from your model to your user interface, you should consider using a library that can calculate differences. Animating small batches of changes is usually going to be faster and provide a more responsive experience than reloading all of your data.

Calculating and acting on differences should also aid you in making a clear separation between data and user interface, and hopefully provide a more declarative approach: your model performs state transition, then your UI code performs appropriate actions based on the calculated differences to that state.

## How to use

### Placeholder Images

```swift
```

Please see the [included examples](/Examples/) for a working sample.


## Requirements

PlaceholderKit requires Swift 4.2 / Xcode 10 or later to compile.

## Installation

You can add PlaceholderKit to your project using Carthage, CocoaPods, Swift Package Manager, or as an Xcode subproject.

### Carthage

```ruby
github "simonlee2/Placeholderkit"
```

### CocoaPods

```ruby
pod 'PlaceholderKit'
```
