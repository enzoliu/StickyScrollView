//
//  ViewController.swift
//  TestStickyScrollView
//
//  Created by Enzo on 2016/7/29.
//  Copyright © 2016 EnzoLiu. All rights reserved.
//

import UIKit
import StickyScrollView

class ViewController: UIViewController, UIScrollViewDelegate {
    weak var scrollView: StickyScrollView?
    weak var imgView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Place your image
        let imageView = UIImageView(image: UIImage(named: "taiwan"))
        let ratio = UIScreen.mainScreen().bounds.width / imageView.frame.width
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, imageView.frame.height * ratio)
        imageView.center = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: imageView.frame.height / 2)
        self.imgView = imageView

        // Initialize StickyScrollView
        let scrollView = StickyScrollView(frame: self.view.frame)
        scrollView.setStickyDisplayHeight(150)
        scrollView.setStickyImage(imageView)
        scrollView.delegate = self

        // Add content
        let someContent = UIView(frame: CGRectMake(0, 150, UIScreen.mainScreen().bounds.width, 750))
        someContent.backgroundColor = UIColor.grayColor()
        scrollView.addSubview(someContent)
        scrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: CGRectGetMaxY(someContent.frame))
        self.scrollView = scrollView

        self.view.addSubview(imageView)
        self.view.addSubview(scrollView)
        self.view.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
