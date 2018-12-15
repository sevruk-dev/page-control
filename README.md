# PageControl
[![CocoaPods](https://img.shields.io/cocoapods/p/Sevruk-PageControl.svg)](https://cocoapods.org/pods/Sevruk-PageControl)
[![CocoaPods](https://img.shields.io/cocoapods/v/Sevruk-PageControl.svg)](http://cocoapods.org/pods/Sevruk-PageControl)
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-green.svg?style=flat)](https://developer.apple.com/swift/)
<img align="right" src="https://github.com/insiderdev/page-control/blob/master/tutorial-resources/demonstration.gif" width=356, height=670/>
</a>

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

3) In view controller create an outlet to a view from storyboard and you're ready to go.

![1.2](https://raw.githubusercontent.com/insiderdev/page-control/master/tutorial-resources/1.2.png)

Here is code example that uses UIScrollView.

``` swift
import UIKit
import PageControl

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: PageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.numberOfPages = Int(scrollView.contentSize.width / scrollView.bounds.width)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.currentPage = page
    }
}
```

## Usage without storyboard

1) Create a PageControl view and add it to your view hierarchy. 
``` swift
let pageControl = PageControl()
addSubview(pageControl)
```

2) Setup pageControl with your needs.
``` swift
pageControl.numberOfPages = 5
pageControl.spacing = 14.0
pageControl.indicatorDiameter = 8.0
pageControl.currentIndicatorDiameter = 12.0
pageControl.indicatorTintColor = .darkGray
pageControl.currentIndicatorTintColor = .green
```

3) And update current page when needed.
``` swift
pageControl.currentPage = 1
```

## Contributing 
I'd love for you to contribute in PageControl. Feel free to submit your pull requests.

## Author

Feel free to contact me via linkedin [Vova Sevruk](https://www.linkedin.com/in/vova-sevruk-838b9210b/) or via email: vovaseuruk@gmail.com

## Licence

PageControl is released under the MIT license.
See [LICENSE](./LICENSE) for details.
