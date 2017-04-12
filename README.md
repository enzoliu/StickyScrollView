# StickyScrollView

[![Version](https://img.shields.io/cocoapods/v/StickyScrollView.svg?style=flat)](http://cocoapods.org/pods/StickyScrollView)
[![License](https://img.shields.io/cocoapods/l/StickyScrollView.svg?style=flat)](http://cocoapods.org/pods/StickyScrollView)
[![Platform](https://img.shields.io/cocoapods/p/StickyScrollView.svg?style=flat)](http://cocoapods.org/pods/StickyScrollView)

**Sicky header for UIScrollView in Swift**

<img src="http://i.imgur.com/1urNt0X.gif" />

## Requirements

## Installation

StickyScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

``` ruby
pod 'StickyScrollView'
```

If you're looking for Swift 2 version, you can get it from branch 'swift2'.  
  
  
## Usage
** Swift 3.x **
```swift
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
        scrollView.setStickyDisplayHeight(height: 150)
        scrollView.setStickyImage(imageView: imageView)
        scrollView.delegate = self

        // ... 
        // adjust scrollView contentSize
        // ...

        // add to view
        self.view.addSubview(imageView)
        self.view.addSubview(scrollView)
    }
}

```

** Object-C **
In your .h file, you need to add `UIScrollViewDelegate` :  
```objective-c
@interface ViewController : UIViewController <UIScrollViewDelegate>
// ...
@end
```  
  
And implement `StickyScrollView` in your .m file :  
```objective-c
@import StickyScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // ...
    // init your image here. (imageView)
    // ...

    // Initialize StickyScrollView
    StickyScrollView *scrollView = [[StickyScrollView alloc] initWithFrame: [self.view frame]];
    [scrollView setStickyImageWithImageView: imageView];
    [scrollView setStickyDisplayHeightWithHeight: 150];
    scrollView.delegate = self;

    // ... 
    // adjust scrollView contentSize
    // ...

    // add to view
    [self.view.addSubview: imageView];
    [self.view.addSubview: scrollView];
}
```  
  
## Advanced usage
set scrollView as sticky header view.
```swift
import StickyScrollView

// you should use UIScrollViewDelegate here.
class ViewController: UIViewController, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        // ...
        // init your image1 and image2 here. 
        // ...

        // Initialize header scroll view
        let bgScrollView = UIScrollView(frame: image1.frame)
        bgScrollView.addSubview(image1)
        bgScrollView.addSubview(image2)
        bgScrollView.contentSize = CGSize(width: image1.frame.width + image2.frame.width, height: image1.frame.height)

        // Initialize StickyScrollView
        let scrollView = StickyScrollView(frame: self.view.frame)
        scrollView.setStickyDisplayHeight(height: 150)
        scrollView.setStickyView(view: bgScrollView)  // This will add bgScrollView into scrollView
        scrollView.delegate = self

        // ... 
        // adjust scrollView contentSize
        // ...

        // add to view
        self.view.addSubview(scrollView)
    }
}
```

You can set scale ratio, alpha ratio or parallel moving ratio by your self, just call :
```swift
    scrollView.setScaleRatio(ratio: 1)
    scrollView.setAlphaRatio(ratio: 0.7)
    scrollView.setParallelRatio(ratio: 0.4)
```

## Change log
v0.1.6 - Bump to Swift 3.  
v0.1.4 - Fix pod [cannot satisfy optional requirement of @objc protocol] error.  
v0.1.3 - Fix vertical scrolling bug.  
v0.1.2 - Now support vertical scrolling behavior in sticky view area.  
v0.1.1 - Now support passing gesture to sticky header view, and support UIView as a sticky header.  
v0.1.0 - Initial release

## Inspired from
- <https://github.com/jamztang/CSStickyHeaderFlowLayout>

## License

StickyScrollView is available under the MIT license. See the LICENSE file for more info.
