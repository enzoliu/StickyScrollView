//
//  StickyScrollView.swift
//
//  Created by enzoliu on 2016/6/20.
//  Copyright © 2016 enzoliu. All rights reserved.
//

import UIKit

public class StickyScrollView: UIScrollView {
    private weak var imgView: UIImageView?
    private var stickyHeight: CGFloat = 0

    // Image scale ratio, 0 ~ 1.
    private var imageScaleRatio: CGFloat = 1

    // Image alpha ratio, 0 ~ 1
    private var imageAlphaRatio: CGFloat = 0.7

    // Image y scale offset moving ratio, 0 ~ 1
    private var imageParallelRatio: CGFloat = 0.3

    /// This interceptor concept is referenced from :
    /// - see: http://stackoverflow.com/questions/26953559/in-swift-how-do-i-have-a-uiscrollview-subclass-that-has-an-internal-and-externa
    public class DelegateProxy: NSObject, UIScrollViewDelegate {
        weak var userDelegate: UIScrollViewDelegate?

        public override func respondsToSelector(aSelector: Selector) -> Bool {
            return super.respondsToSelector(aSelector) || userDelegate?.respondsToSelector(aSelector) == true
        }

        public override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
            if userDelegate?.respondsToSelector(aSelector) == true {
                return userDelegate
            } else {
                return super.forwardingTargetForSelector(aSelector)
            }
        }

        /**
         This is a intercept function of scrollViewDidScroll in UIScrollViewDelegate.

         - parameter scrollView: UIScrollView
         */
        public func scrollViewDidScroll(scrollView: UIScrollView) {
            if let sc = scrollView as? StickyScrollView {
                sc.updateFrame()
            }
            userDelegate?.scrollViewDidScroll?(scrollView)
        }
    }

    private var delegateProxy = DelegateProxy()

    /**
     Init function (by frame), set delegate to interceptor.

     - parameter frame: CGRect

     - returns: An initialized view object.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = delegateProxy

        // -----------------------------------------------
        // DON'T CHANGE THIS (OR YOUR WILL GET NO EFFECT).
        // -----------------------------------------------
        // To show the image under this scrollView,
        // we need background color to be clear color.
        // If you need to set background color,
        // add a container in this scroll view,
        // and you can set any background color you want.
        self.backgroundColor = UIColor.clearColor()
    }

    /**
     Init function (by coder), set delegate to interceptor.

     - parameter aDecoder: NSCoder

     - returns: self
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = delegateProxy
    }

    /// Override getter and setter to redirect to interceptor.
    public override var delegate: UIScrollViewDelegate? {
        get {
            return delegateProxy.userDelegate
        }
        set {
            self.delegateProxy.userDelegate = newValue
        }
    }

    /**
     Set the sticky image under the scrollView.

     - parameter imageView: UIImageView
     */
    public func setStickyImage(imageView: UIImageView) {
        self.imgView = imageView
    }

    /**
     Set the sticky height of the default image display area.

     - parameter height: CGFloat
     */
    public func setStickyDisplayHeight(height: CGFloat) {
        self.stickyHeight = height
    }

    /**
     This method transform the imageView by scrolling action.
     */
    public func updateFrame() {
        guard let imgView = self.imgView else {
            return
        }
        let yOffset = -self.contentOffset.y
        if yOffset > 0 {
            let scale = 1 + (yOffset / imgView.frame.height) * imageScaleRatio
            imgView.transform = CGAffineTransformMakeScale(scale, scale)
            imgView.frame = CGRectMake(imgView.frame.origin.x, 0, imgView.frame.width, imgView.frame.height)
            imgView.alpha = 1

        } else if yOffset >= -stickyHeight {
            imgView.frame = CGRectMake(imgView.frame.origin.x, yOffset * imageParallelRatio, imgView.frame.width, imgView.frame.height)
            imgView.alpha = (stickyHeight - abs(yOffset) * imageAlphaRatio) / stickyHeight
        }
    }
}
