//
//  ViewController.swift
//  ImageSlider
//
//  Created by Shailendra Kumar Ram on 21/01/20.
//  Copyright © 2020 nitin chawla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imgScrollView: UIScrollView!
    @IBOutlet weak var imgPageController: UIPageControl!
    
    let imageArray = ["imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider","imageslider"]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        imgScrollView.delegate = self
        imgScrollView.isPagingEnabled = true
        
        configurePageControl()
        imgScrollView.delegate = self
        self.view.addSubview(imgScrollView)
        for  i in stride(from: 0, to: imageArray.count, by: 1) {
            var frame = CGRect.zero
            frame.origin.x = self.imgScrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.imgScrollView.frame.size
            self.imgScrollView.isPagingEnabled = true
            
            let myImage:UIImage = UIImage(named: imageArray[i])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.contentMode = UIView.ContentMode.scaleAspectFit
            myImageView.frame = frame
            imgScrollView.addSubview(myImageView)
        }
        
        self.imgScrollView.contentSize = CGSize(width: self.imgScrollView.frame.size.width * CGFloat(imageArray.count), height: self.imgScrollView.frame.size.height)
        _ = Timer.scheduledTimer(timeInterval: 2.0 , target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.imgPageController.numberOfPages = imageArray.count
        self.imgPageController.currentPage = 0
        self.imgPageController.tintColor = UIColor.red
        self.imgPageController.pageIndicatorTintColor = UIColor.black
        self.imgPageController.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(imgPageController)
    }
    
    @objc func moveToNextPage (){
        let pageWidth:CGFloat = self.imgScrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 14
        let contentOffset:CGFloat = self.imgScrollView.contentOffset.x
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth {
            slideToX = 0
      }
        
   self.imgScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth,   height:self.imgScrollView.frame.height), animated: true)
        let pageNumber = round(imgScrollView.contentOffset.x / imgScrollView.frame.size.width)
            imgPageController.currentPage = Int(pageNumber)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(imgScrollView.contentOffset.x / scrollView.frame.size.width)
        imgPageController.currentPage = Int(pageNumber)
    }
    
    
}
