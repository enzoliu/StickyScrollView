//
//  StickyScrollView.swift
//
//  Created by enzoliu on 2016/6/20.
//  Copyright © 2016 enzoliu. All rights reserved.
//

import UIKit

public class StickyScrollView: UIScrollView, UIGestureRecognizerDelegate {
    private weak var stickyView: UIView?
    private var stickyHeight: CGFloat = 0
    
    // Sticky scale ratio, 0 ~ 1.
    private var stickyScaleRatio: CGFloat = 1
    
    // Sticky alpha ratio, 0 ~ 1.
    private var stickyAlphaRatio: CGFloat = 0.7
    
    // Sticky y scale offset moving ratio, 0 ~ 1.
    private var stickyParallelRatio: CGFloat = 0.5
    
    /// This interceptor concept is referenced from :
    /// - see: http://stackoverflow.com/questions/26953559/in-swift-how-do-i-have-a-uiscrollview-subclass-that-has-an-internal-and-externa
    public class DelegateProxy: NSObject, UIScrollViewDelegate {
        weak var userDelegate: UIScrollViewDelegate?
        
        public override func responds(to aSelector: Selector!) -> Bool {
            return super.responds(to: aSelector) || userDelegate?.responds(to: aSelector) == true
        }
        
        public override func forwardingTarget(for aSelector: Selector!) -> Any? {
            if userDelegate?.responds(to: aSelector) == true {
                return userDelegate
            } else {
                return super.forwardingTarget(for: aSelector)
            }
        }
        
        /**
         This is a intercept function of scrollViewDidScroll in UIScrollViewDelegate.
         
         - parameter scrollView: UIScrollView
         */
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
     This method transform the imageView by scrolling action.
     */
    public func updateFrame() {
        guard let stickyView = self.stickyView else {
            return
        }
        if self.contentOffset.y < 0 {
            let scale = 1 + (abs(self.contentOffset.y) / stickyView.frame.height) * stickyScaleRatio
            stickyView.transform = CGAffineTransform(scaleX: scale, y: scale)
            stickyView.frame = CGRect(x: stickyView.frame.origin.x,
                                      y: self.contentOffset.y,
                                      width: stickyView.frame.width,
                                      height: stickyView.frame.height)
            stickyView.alpha = 1
            
        } else if self.contentOffset.y <= stickyHeight {
            stickyView.frame = CGRect(x: stickyView.frame.origin.x,
                                      y: self.contentOffset.y * stickyParallelRatio,
                                      width: stickyView.frame.width,
                                      height: stickyView.frame.height)
            stickyView.alpha = (stickyHeight - self.contentOffset.y * stickyAlphaRatio) / stickyHeight
        }
    }
    
    //
    // MARK:- Delegate (UIGestureRecognizerDelegate)
    //
    
    @objc public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let bkScrollView = self.stickyView as? UIScrollView else {
            return false
        }
        if gestureRecognizer == self.panGestureRecognizer && otherGestureRecognizer == bkScrollView.panGestureRecognizer {
            let velocity = self.panGestureRecognizer.velocity(in: self)
            if abs(velocity.x) > abs(velocity.y) {
                return true
            }
        }
        return false
    }
    
    @objc public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let bkScrollView = self.stickyView as? UIScrollView else {
            return false
        }
        if gestureRecognizer == self.panGestureRecognizer && otherGestureRecognizer == bkScrollView.panGestureRecognizer {
            let velocity = self.panGestureRecognizer.velocity(in: self)
            if abs(velocity.x) < abs(velocity.y) {
                return true
            }
        }
        return false
    }
    
    //
    // MARK:- Config
    //
    
    /**
     Set the sticky image under the scrollView.
     
     - parameter imageView: UIImageView
     */
    public func setStickyImage(imageView: UIImageView) {
        self.setStickyView(view: imageView)
    }
    
    /**
     Set the sticky view under the scrollView.
     
     - parameter view: UIView
     */
    public func setStickyView(view: UIView) {
        self.stickyView = view
        self.addSubview(view)
        view.layer.zPosition = -1
    }
    
    /**
     Set the sticky height of the default image display area.
     
     - parameter height: CGFloat
     */
    public func setStickyDisplayHeight(height: CGFloat) {
        self.stickyHeight = height
    }
    
    //
    // MARK:- Optional Config
    //
    
    /**
     This function defines the sticky header scale ratio when user scroll down.
     The default value is 1.
     - parameter ratio: CGFloat (0 <= ratio <= 1)
     */
    public func setScaleRatio(ratio: CGFloat) {
        self.stickyScaleRatio = ratio
    }
    
    /**
     This function defines the sticky header alpha ratio when user scroll up.
     The default value is 0.7.
     - parameter ratio: CGFloat (0 <= ratio <= 1)
     */
    public func setAlphaRatio(ratio: CGFloat) {
        self.stickyAlphaRatio = ratio
    }
    
    /**
     This function defines the sticky header move up ratio when user scroll up.
     The default value is 0.5.
     - parameter ratio: CGFloat (0 <= ratio <= 1)
     */
    public func setParallelRatio(ratio: CGFloat) {
        self.stickyParallelRatio = ratio
    }
}
