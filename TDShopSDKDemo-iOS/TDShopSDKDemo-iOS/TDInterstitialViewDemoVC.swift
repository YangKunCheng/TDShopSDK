//
//  TDInterstitialViewDemoVC.swift
//  TDShopSDKDemo-iOS
//
//  Created by xilanhua on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK
import SnapKit

class TDInterstitialViewDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSubViews()
    }
    
    func initSubViews() {
        view.backgroundColor = UIColor.white
        let showInterBtn = UIButton()
        showInterBtn.setTitle("Show nterstitial View", for: .normal)
        showInterBtn.backgroundColor = UIColor.lightGray
        showInterBtn.setTitleColor(UIColor.white, for: .normal)
        showInterBtn.addTarget(self, action: #selector(showInterBtnClick), for: .touchUpInside)
        self.view.addSubview(showInterBtn)
        showInterBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
    }
    
    @objc func showInterBtnClick() {
        _ = TDShopSDK.showInterstitialView(placementId: "myshop_ios_demo_interstitialr_001")
    }
}
