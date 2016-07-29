# StickyScrollView

[![Version](https://img.shields.io/cocoapods/v/StickyScrollView.svg?style=flat)](http://cocoapods.org/pods/StickyScrollView)
[![License](https://img.shields.io/cocoapods/l/StickyScrollView.svg?style=flat)](http://cocoapods.org/pods/StickyScrollView)
[![Platform](https://img.shields.io/cocoapods/p/StickyScrollView.svg?style=flat)](http://cocoapods.org/pods/StickyScrollView)
![](https://img.shields.io/badge/language-swift_2\+-brightgreen.svg)
[![CI Status](http://img.shields.io/travis/Enzo Liu/StickyScrollView.svg?style=flat)](https://travis-ci.org/Enzo Liu/StickyScrollView)

**Sicky header for UIScrollView in Swift**

## Requirements

## Installation

StickyScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'StickyScrollView'
```

## Usage
```
import StickyScrollView

// you should use UIScrollViewDelegate here.
class ViewController: UIViewController, UIScrollViewDelegate {
	override func viewDidLoad() {
        super.viewDidLoad()

        // ...
        // init your image here. (imageView)
        // ...

        // Initialize StickyScrollView
        let scrollView = StickyScrollView(frame: self.view.frame)
        scrollView.setStickyDisplayHeight(150)
        scrollView.setStickyImage(imageView)
        scrollView.delegate = self

        // add to view
        self.view.addSubview(imageView)
        self.view.addSubview(scrollView)
    }
}

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Enzo Liu, item.search@gmail.com

## License

StickyScrollView is available under the MIT license. See the LICENSE file for more info.
