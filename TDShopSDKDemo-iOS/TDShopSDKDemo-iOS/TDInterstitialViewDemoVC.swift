//
//  TDInterstitialViewDemoVC.swift
//  TDShopSDKDemo-iOS
//
//  Created by xilanhua on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK

class TDInterstitialViewDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSubViews()
    }
    
    func initSubViews() {
        view.backgroundColor = UIColor.lightGray
        let showInterBtn = UIButton.init(frame: CGRect.init(x: 10, y: 100, width: UIScreen.main.bounds.size.width-20, height: 44))
        showInterBtn.setTitle("Show", for: .normal)
        showInterBtn.backgroundColor = UIColor.lightGray
        showInterBtn.setTitleColor(UIColor.white, for: .normal)
        showInterBtn.addTarget(self, action: #selector(showInterBtnClick), for: .touchUpInside)
        self.view.addSubview(showInterBtn)
    }
    
    @objc func showInterBtnClick() {
        _ = TDShopSDK.showInterstitialView(placementId: "icon2")
    }
}
