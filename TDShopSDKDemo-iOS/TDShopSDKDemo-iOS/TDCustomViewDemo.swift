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

    var randomCustomView:TDRandomCustomView?
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
            let customView = TDMutiCustomView.init(viewId: placementId, tags: tags)
            self.view.addSubview(customView)
           customView.frame = CGRect.init(x: 10, y: 200, width: UIScreen.main.bounds.size.width-20, height: 100)
            customView.setupView(resources: resources)
            customView.handleWhenViewAppear()
        }
        
        let randomCustomViewBtn = UIButton()
        randomCustomViewBtn.setTitle("Show Random View", for: .normal)
        randomCustomViewBtn.backgroundColor = UIColor.lightGray
        randomCustomViewBtn.setTitleColor(UIColor.white, for: .normal)
        randomCustomViewBtn.addTarget(self, action: #selector(showRandomViewBtnClick), for: .touchUpInside)
        self.view.addSubview(randomCustomViewBtn)
        randomCustomViewBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 50))
        }

        randomCustomView = TDRandomCustomView.init(viewId: placementId, tags: tags, timeInterval: 10)
    
        
    }
    
    @objc func showRandomViewBtnClick(){
        
        
        let placementId = "myshop_ios_demo_tag_001"
        let tags = ["common"]
        TDShopSDK.getAdResourcesInfo(placementId: placementId, tags: tags) {  (resources) in

            self.randomCustomView?.startShowInView(resources: resources, superView: self.view, offsetY: UIScreen.main.bounds.size.height/2)
        }
    }
}

