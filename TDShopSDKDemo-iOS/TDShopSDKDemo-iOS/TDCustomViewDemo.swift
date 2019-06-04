//
//  TDCustomViewDemo.swift
//  TDShopSDKDemo-iOS
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK

class TDCustomViewDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initCustomView()
    }

    func initCustomView() {
        view.backgroundColor = UIColor.white
        let customViewLb = UILabel.init(frame: CGRect.init(x: 10, y: 155, width: 150, height: 25))
        customViewLb.text = "Custom View:"
        view.addSubview(customViewLb)
        
        let placementId = "myshop_ios_demo_tag_001"
        let tags = ["common"]
        TDShopSDK.getAdResourcesInfo(placementId: placementId, tags: tags) { (resources) in
            let customView = CustomView.init(viewId: placementId, tags: tags)
            self.view.addSubview(customView)
           customView.frame = CGRect.init(x: 10, y: 200, width: UIScreen.main.bounds.size.width-20, height: 100)
            customView.setupView(resources: resources)
            customView.handleWhenViewAppear()
        }
    }
}

class CustomView: TDCustomView, UIScrollViewDelegate {
    
    var viewId:String!
    var tags:[String]?
    var pageCtrl:UIPageControl!
    override init(viewId: String, tags: [String]?) {
        self.viewId = viewId
        self.tags = tags
        super.init(viewId: viewId, tags: tags)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //click event handle
    @objc func click(button:UIButton){
        super.handleViewDidClick(button.tag)
    }
    
    func setupView(resources:[TDAdResourcesModel]) {
        //set up your custom view
        let scrollView = UIScrollView.init(frame: self.bounds)
        self.addSubview(scrollView)
        scrollView.contentSize = CGSize.init(width: CGFloat(resources.count) * self.bounds.size.width, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        
        let resourceCount:CGFloat = resources.count == 0 ? 1 : CGFloat(resources.count);
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        let pageCtrlW:CGFloat = 30 * resourceCount
        pageCtrl = UIPageControl.init(frame: CGRect.init(x: width-pageCtrlW-10, y: height-30, width: pageCtrlW, height: 20))
        pageCtrl.currentPage = 0
        pageCtrl.numberOfPages = resources.count
        pageCtrl.pageIndicatorTintColor = UIColor.gray
        pageCtrl.currentPageIndicatorTintColor = UIColor.orange
        self.addSubview(pageCtrl)
        
        if resourceCount < 2 {
            pageCtrl.isHidden = true
        }
        
        var x:CGFloat = 0
        var index = 0
        for adInfo in resources {
            
            let contentView = UIView.init(frame: CGRect.init(x: x, y: 0, width: width, height: height))
            scrollView.addSubview(contentView)
            scrollView.bounces = false
            
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height-45))
            imageView.sd_setImage(with: URL.init(string: adInfo.imageUrl))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            contentView.addSubview(imageView)
            
            var tag = "Tag:"
            if let tags = self.tags {
                for tag1 in tags {
                    tag = tag  + tag1 + " "
                }
            }
            let label0 = UILabel.init(frame: CGRect.init(x: 0, y: height-45, width: width, height: 20))
            label0.text = "PId:" + self.viewId
            label0.font = UIFont.systemFont(ofSize: 13)
            label0.textAlignment = .center
            contentView.addSubview(label0)
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: height-15-15, width: width, height: 15))
            label.text = tag
            label.font = UIFont.systemFont(ofSize: 13)
            label.textAlignment = .center
            contentView.addSubview(label)
            
            let label2 = UILabel.init(frame: CGRect.init(x: 0, y: height-15, width: width, height: 15))
            label2.text = "content:" + adInfo.content
            label2.font = UIFont.systemFont(ofSize: 13)
            label2.textAlignment = .center
            contentView.addSubview(label2)
            
            let btn = UIButton.init(frame: self.bounds)
            btn.tag = index
            btn.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
            contentView.addSubview(btn)
            index += 1
            x = width + x
        }
        self.backgroundColor = UIColor.yellow
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currPage = scrollView.contentOffset.x / self.bounds.size.width
        self.pageCtrl.currentPage = Int(currPage)
    }
}
