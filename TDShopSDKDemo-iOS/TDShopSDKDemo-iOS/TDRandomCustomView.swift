//
//  TDRandomCustomView.swift
//  TDShopSDKDemo-iOS
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK

class TDRandomCustomView: TDCustomView {
    
    var viewId:String!
    var tags:[String]!
    var timeInterval:CGFloat!
    var label:UILabel!
    var imageView:UIImageView!
    var resources:[TDAdResourcesModel]!
    var isShowing = false
     init(viewId: String, tags: [String]?,timeInterval:CGFloat) {
        self.viewId = viewId
        self.tags = tags
        self.timeInterval = timeInterval
        super.init(viewId: viewId, tags: tags)
        self.isHidden = true
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        
        self.frame = CGRect.init(x: 0, y: 0, width: 200, height: 55)
        label = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: self.bounds.size.width, height: 15))
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 14)
        
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 15, width: self.bounds.size.width, height: 45))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        
        let cornerLayer = CAShapeLayer.init()
        cornerLayer.path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.bottomLeft]  , cornerRadii: CGSize.init(width: self.bounds.size.height/2, height: self.bounds.size.height/2)).cgPath
        self.layer.masksToBounds = true;
        self.layer.mask = cornerLayer;
        
    }
    
    func startShowInView(resources:[TDAdResourcesModel],superView:UIView,offsetY:CGFloat) {
        
        self.resources = resources
        superView.addSubview(self)
        self.frame = CGRect.init(x: superView.bounds.size.width, y: offsetY, width: 200, height: 50)
        if self.resources.count < 1 {
            return
        }
        if self.isShowing {
            return
        }
        self.isShowing = true
        self.perform(#selector(show), with: nil, afterDelay: 4)
    }
    
    
    @objc func show() {
        
        self.isHidden = false
        let randomIndex = Int(arc4random()) % self.resources.count
        let resource = self.resources?[randomIndex]
        imageView.sd_setImage(with: URL.init(string: resource?.imageUrl ?? ""), completed: nil)
        label.text = resource?.content
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = .init(translationX: -self.bounds.size.width, y: 0)
        }) { (success) in
            self.perform(#selector(self.hide), with: nil, afterDelay: 2)
        }
    }
    
    @objc func hide() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = .identity
        }) { (success) in
            self.isHidden = true
            self.perform(#selector(self.show), with: nil, afterDelay: 4)
        }
    }
    @objc func click(button:UIButton){
        super.handleViewDidClick(button.tag)
    }
    
    deinit {
        TDRandomCustomView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.show), object: nil)
        TDRandomCustomView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.hide), object: nil)
    }

}
