# PageControl
[![CocoaPods](https://img.shields.io/cocoapods/p/Sevruk-PageControl.svg)](https://cocoapods.org/pods/Sevruk-PageControl)
[![CocoaPods](https://img.shields.io/cocoapods/v/Sevruk-PageControl.svg)](http://cocoapods.org/pods/Sevruk-PageControl)
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-green.svg?style=flat)](https://developer.apple.com/swift/)

<img align="right" src="https://github.com/insiderdev/page-control/blob/master/tutorial-resources/demonstration.gif" width=356, height=670/>
</a>
<br><br/>

## Requirements
- iOS 9.0+
- Xcode 7.0+

## Installation

[CocoaPods](https://cocoapods.org):

Add folowing line to Podfile and run 'pod instal'.
```
pod 'Sevruk-PageControl'
``` 

Or just drag and drop FoldingCell.swift file to your project

## Usage with storyboard
1) Add a new UIView to storyboard.

2) Inherit view from `PageControl`.

![1.1](https://raw.githubusercontent.com/insiderdev/page-control/master/tutorial-resources/1.1.png)

3) In view controller create an outlet to a view from storyboard. 

![1.2](https://raw.githubusercontent.com/insiderdev/page-control/master/tutorial-resources/1.2.png)

## Usage without storyboard
Create a PageControl view and add it to view hierarchy. 
``` swift
let pageControl = PageControl()
addSubview(pageControl)
```

## Licence

PageControl is released under the MIT license.
See [LICENSE](./LICENSE) for details.
