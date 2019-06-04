//
//  TDShopSDKDemoListVC.swift
//  TDShopSDKDemo-iOS
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SnapKit

enum TDShopSDKDemoType {
    
    case iconView
    case bannerView
    case customView
    
}



class TDShopSDKDemoListVC: UIViewController {
    
    var demoArr:[TDDemoModel]!
    var demoListView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TDShopSDK Demo list"
        self.initViews()
        self.initData()
        self.setUpViews()
    }
    
    func initViews() {
        
        self.view.backgroundColor = UIColor.white
        
        let demoListTableView = UITableView.init(frame: self.view.bounds, style: .plain)
        demoListTableView.backgroundColor = UIColor.groupTableViewBackground
        demoListTableView.rowHeight = 50
        demoListTableView.separatorColor = UIColor.groupTableViewBackground
        demoListTableView.tableFooterView = .init()
        demoListTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        demoListTableView.register(TDDemoListCell.self, forCellReuseIdentifier: "TDDemoListCell")
        self.view.addSubview(demoListTableView)
        demoListTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        demoListTableView.delegate = self
        demoListTableView.dataSource = self
        self.demoListView = demoListTableView
    }
    
    func initData() {
        
        let dataArr:[[String:Any]] = [["type":TDShopSDKDemoType.iconView ,"title":"TDIconView","desc":"common"],
                                      ["type":TDShopSDKDemoType.bannerView ,"title":"TDBannerView","desc":"common"],
                                      ["type":TDShopSDKDemoType.customView ,"title":"TDCustomView","desc":"common"],
            ]
        var demoList = [TDDemoModel]()
        for demoData in dataArr {
            let model =  TDDemoModel()
            model.type = demoData["type"] as! TDShopSDKDemoType
            model.desc = demoData["desc"] as! String
            model.name = demoData["title"] as! String
            demoList.append(model)
        }
        self.demoArr = demoList
        
    }
    
    func setUpViews() {
        self.demoListView.reloadData()
    }
}

extension TDShopSDKDemoListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.demoArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TDDemoListCell", for: indexPath) as! TDDemoListCell
        let model = self.demoArr[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.demoArr[indexPath.row]
        
        var vc:UIViewController?
        
        switch model.type {
        case .iconView:
            vc = TDIconViewDemoVC()
        case .bannerView:
            vc = TDBannerViewDemoVC()
        case .customView:
            vc = TDCustomViewDemo()

        }
        
        if let vc1 = vc {
            vc1.title = model.name
            self.navigationController?.pushViewController(vc1, animated: true)
        }
        
    }
    
    
}




class TDDemoModel: NSObject {
    
    var type:TDShopSDKDemoType = .iconView
    var name:String = ""
    var desc:String = ""
}

class TDDemoListCell:UITableViewCell {
    
    var titleLb:UILabel!
    var descLb:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubViews()
        self.selectionStyle = .none
        self.clipsToBounds = true
    }
    
    func initSubViews() {
        
        titleLb = UILabel.init()
        titleLb.font = UIFont.systemFont(ofSize: 16)
        titleLb.textColor = UIColor.black
        titleLb.textAlignment = .left
        self.contentView.addSubview(titleLb)
        
        descLb = UILabel.init()
        descLb.font = UIFont.systemFont(ofSize: 14)
        descLb.textColor = UIColor.lightGray
        descLb.textAlignment = .left
        descLb.numberOfLines = 2
        self.contentView.addSubview(descLb)
        
    }
    
    func updateCell(model:TDDemoModel) {
        
        self.titleLb.text = model.name
        self.descLb.text = model.desc
        
//        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
        }
        
        descLb.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(titleLb.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
