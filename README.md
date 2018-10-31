# AppiumDemo
macOS app that controls a connected iOS device via Appium

## Requirements
* Xcode 10.0
* Mac running on 10.11+
* iOS Device running iOS 9.3+

## Prerequisites
* [CocoaPods](https://cocoapods.org/)
* [HomeBrew](https://brew.sh/)
* [Node.js](https://nodejs.org/en/)
* [Appium 1.7.1](https://github.com/appium/appium-desktop/releases/)

## Installation
Appium iOS real device support depends on a central third-party software suite, libimobiledevice, which is easily installable with Homebrew:

```
brew install libimobiledevice
```

In addition to the dependency on libimobiledevice, Appium support for real devices running iOS 9.3 and above using Xcode 8+ also depends on ios-deploy, which is easily available through Homebrew or npm:

```
brew install ios-deploy
```

```
npm install -g ios-deploy --unsafe-perm=true
```

To verify that all of Appium's dependencies are met you can use appium-doctor. Install it with npm install -g appium-doctor, then run the appium-doctor command, supplying the --ios flag to verify that all of the dependencies are set up correctly.

## Usage
Run Appium server on a Mac, navigate to Appium.swift and set the constants accordingly.
