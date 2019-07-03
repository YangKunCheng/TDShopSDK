//
//  TDIconViewDemoVC.swift
//  TDShopSDKDemo-iOS
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK
class TDImageAdViewDemoVC: UIViewController {

    
    var templeImageAdView:TDImageADView!
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
        
        let viewWH:CGFloat = 50
        let fixedLb = UILabel.init(frame: CGRect.init(x: leadingLeft, y: currY, width: 150, height: titleLbH))
        fixedLb.text = "Fixed Entrance:"
        scrollView.addSubview(fixedLb)
        
        currY += titleLbH + space
        // Fixed Entrance
        let fixedImageAdView =  TDImageADView.init(frame: CGRect.init(x:(screenW-viewWH)/2, y: currY, width: viewWH, height: viewWH), viewId: "myshop_ios_demo_icon_001")
        scrollView.addSubview(fixedImageAdView)
        
        currY += viewWH + space
        // Custom Fixed Entrance
        let customFixedLb = UILabel.init(frame: CGRect.init(x: leadingLeft, y: currY, width: 200, height: titleLbH))
        customFixedLb.text = "Custom Fixed Entrance:"
        scrollView.addSubview(customFixedLb)
        
         currY += titleLbH + space
        
        let customFixedImageAdView =  TDCustomImageAdView.init(frame: CGRect.init(x:(screenW-viewWH)/2, y: currY, width: viewWH+15, height: viewWH+15))
        scrollView.addSubview(customFixedImageAdView)
        
        currY += viewWH+15 + space
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
        
        let templeImageAdView =  TDImageADView.init(frame: CGRect.init(x:(screenW-viewWH)/2, y: currY, width: viewWH, height: viewWH), viewId: "myshop_ios_demo_icon_001")
        scrollView.addSubview(templeImageAdView)
        templeImageAdView.isHidden = true
        self.templeImageAdView = templeImageAdView
    }
    
    @objc func showTempleBtnClick() {
        
        if templeImageAdView.isHidden == false {
            return
        }
        templeImageAdView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
            {[weak self] in
                self?.templeImageAdView.isHidden = true
        })
    }

}


class TDCustomImageAdView: UIView {
    
    var fixedImageAdView:TDImageADView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSubViews()
    }
    
    func initSubViews() {
        
        let closeBtnWH:CGFloat = 15
        
        let fixIconViewWH = self.bounds.size.width-closeBtnWH
        fixedImageAdView =  TDImageADView.init(frame: CGRect.init(x:0, y: closeBtnWH, width: fixIconViewWH, height: fixIconViewWH), viewId: "myshop_ios_demo_icon_001")
        addSubview(fixedImageAdView)
        
        let closeBtn = UIButton.init(frame: CGRect.init(x: fixIconViewWH, y: 0, width: closeBtnWH, height: closeBtnWH))
        closeBtn.layer.cornerRadius = closeBtnWH/2
        closeBtn.layer.borderColor = UIColor.black.cgColor
        closeBtn.layer.borderWidth = 0.5
        closeBtn.clipsToBounds = true
        closeBtn.setImage(UIImage.init(named: "close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        addSubview(closeBtn)
    }
    
    @objc func closeBtnClick() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
