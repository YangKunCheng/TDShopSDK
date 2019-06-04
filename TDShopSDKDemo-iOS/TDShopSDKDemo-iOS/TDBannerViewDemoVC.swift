//
//  TDBannerViewDemoVC.swift
//  TDShopSDKDemo-iOS
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK

class TDBannerViewDemoVC: UIViewController {

    var templeIconView:TDBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubViews()
    }
    
    func initSubViews() {
        let scrollView = UIScrollView.init(frame: CGRect.zero)
        scrollView.backgroundColor = .groupTableViewBackground
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        var currY:CGFloat = 40
        let leadingLeft:CGFloat = 15
        let titleLbH:CGFloat = 25
        let space:CGFloat = 20
        let screenW:CGFloat = UIScreen.main.bounds.size.width
        let screenH:CGFloat = UIScreen.main.bounds.size.height
        let viewH:CGFloat = 50
        let viewW:CGFloat = viewH * 720.0/372
        
        let fixedLb = UILabel.init(frame: CGRect.init(x: leadingLeft, y: currY, width: 150, height: titleLbH))
        fixedLb.text = "Fixed Entrance:"
        scrollView.addSubview(fixedLb)
        
        currY += titleLbH + space
        // Fixed Entrance
        let fixedBannerView =  TDBannerView(frame: CGRect(x: (screenW-viewW)/2, y: currY, width: viewW, height: viewH), viewId: "myshop_ios_demo_banner_001")
        scrollView.addSubview(fixedBannerView)
        fixedBannerView.handleWhenViewAppear()
        
        currY += viewH + space
        // Custom Fixed Entrance
        let customFixedLb = UILabel.init(frame: CGRect.init(x: leadingLeft, y: currY, width: 200, height: titleLbH))
        customFixedLb.text = "Custom Fixed Entrance:"
        scrollView.addSubview(customFixedLb)
        
        currY += titleLbH + space
        
        let customFixedIconView =  TDCustomBannerView.init(frame: CGRect.init(x:(screenW-viewW)/2, y: currY, width: viewW+15, height: viewH+15))
        scrollView.addSubview(customFixedIconView)
        customFixedIconView.handleWhenViewAppear()
        
        currY += viewH + 15 + space
        // Temple Entrance
        let templeLb = UILabel.init(frame: CGRect.init(x: leadingLeft, y: currY, width: 150, height: titleLbH))
        templeLb.text = "Temple Entrance:"
        scrollView.addSubview(templeLb)
        
        let showTempleBtn = UIButton.init(frame: CGRect.init(x: 150+20, y: currY, width: 200, height: 30))
        showTempleBtn.setTitle("show Temple Entrance", for: .normal)
        showTempleBtn.backgroundColor = UIColor.orange
        showTempleBtn.addTarget(self, action: #selector(showTempleBtnClick), for: .touchUpInside)
        scrollView.addSubview(showTempleBtn)
        currY += titleLbH + space
        
        let templeIconView =  TDBannerView.init(frame: CGRect.init(x:(screenW-viewW)/2, y: currY, width: viewW, height: viewH), viewId: "myshop_ios_demo_banner_001")
        scrollView.addSubview(templeIconView)
        templeIconView.handleWhenViewAppear()
        templeIconView.isHidden = true
        self.templeIconView = templeIconView
    }
    
    @objc func showTempleBtnClick() {
        
        if templeIconView.isHidden == false {
            return
        }
        templeIconView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
            {[weak self] in
                self?.templeIconView.isHidden = true
        })
    }
}

class TDCustomBannerView: UIView {
    
    var fixedBannerView:TDBannerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSubViews()
    }
    
    func initSubViews() {
        
        let closeBtnWH:CGFloat = 15
        let viewH:CGFloat = 50
        let viewW:CGFloat = viewH * 720.0/372
        let fixBannerViewWH = self.bounds.size.width-closeBtnWH
        fixedBannerView =  TDBannerView(frame: CGRect(x: 0, y: closeBtnWH, width: viewW, height: viewH), viewId: "myshop_ios_demo_banner_001")
        addSubview(fixedBannerView)
        
        let closeBtn = UIButton.init(frame: CGRect.init(x: fixBannerViewWH, y: 0, width: closeBtnWH, height: closeBtnWH))
        closeBtn.layer.cornerRadius = closeBtnWH/2
        closeBtn.layer.borderColor = UIColor.black.cgColor
        closeBtn.layer.borderWidth = 0.5
        closeBtn.clipsToBounds = true
        closeBtn.setImage(UIImage.init(named: "close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        addSubview(closeBtn)
    }
    
    func handleWhenViewAppear() {
        fixedBannerView.handleWhenViewAppear()
    }
    
    @objc func closeBtnClick() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
