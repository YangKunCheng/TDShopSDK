//
//  CustomView.swift
//  TSShopSDKDemo
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import TDShopSDK
class TDMutiCustomView: TDCustomView,UIScrollViewDelegate {
    
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
    
    func setupView(resources:[TDAdResourcesModel]) {
        
        let scrollView = UIScrollView.init(frame: self.bounds)
        self.addSubview(scrollView)
        scrollView.contentSize = CGSize.init(width: CGFloat(resources.count) * self.bounds.size.width, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self;
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
            
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 10, width: width, height: height - 20 - 15))
            imageView.sd_setImage(with: URL.init(string: adInfo.imageUrl))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            contentView.addSubview(imageView)

            let label2 = UILabel.init(frame: CGRect.init(x: 0, y: height-20, width: width, height: 15))
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
        
        let closeBtn = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 100, height: 30))
        closeBtn.setTitle("Close", for: .normal)
        closeBtn.backgroundColor = UIColor.white
        closeBtn.setTitleColor(UIColor.orange, for: .normal)
        closeBtn.layer.borderColor = UIColor.black.cgColor
        closeBtn.layer.borderWidth = 1
        closeBtn.addTarget(self, action: #selector(close(button:)), for: .touchUpInside)
        self.addSubview(closeBtn)
        
        self.backgroundColor = UIColor.yellow
        
        
    }
    @objc func close(button:UIButton){
        self.isHidden = true
    }
    @objc func click(button:UIButton){
        super.handleViewDidClick(button.tag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currPage = scrollView.contentOffset.x / self.bounds.size.width
        self.pageCtrl.currentPage = Int(currPage)
    }
    
}
