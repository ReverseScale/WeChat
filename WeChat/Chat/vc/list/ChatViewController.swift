//
//  ChatViewController.swift
//  WeChat
//
//  Created by panzhijun on 2019/5/10.
//  Copyright © 2019 panzhijun. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    // tableView
    fileprivate lazy var tableView : UITableView = {
        let tableView =  UITableView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: Screen_W,
                                                   height: Screen_H),
                                     style: UITableView.Style.plain)
        return tableView
    }()
    
    fileprivate   var  effectView : UIVisualEffectView?
    fileprivate var viewLine1: UIView = UIView()
    // 聊天列表数组
    fileprivate var msgArray : [DBChat] = [DBChat]()
    fileprivate var searchController : SearchViewController = {
        
        let searchController = SearchViewController.init(searchResultsController: UIViewController())
        return searchController
    }()
    
    
    var searchView = SearchView()
    var tableViewSearch : UITableView!
    var imagV = UIImageView()
    var btnCancle = UIButton()
    var back = UIView()
    var topView = UIView()
    var btnSearch = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        view.backgroundColor = UIColor.white

 
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        self.navigationController?.navigationBar.shadowImage = UIImage()
   
        
     

        
        // 初始化View
        setupMainView()
        
        searchAndReload()
        
        registerNotification()
    }
    

    func setupMainView()   {
        
        self.tableView.register(ChatGoupListTableViewCell.self, forCellReuseIdentifier: "ChatGoupListTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.sectionHeaderHeight = 0.1
        self.tableView.sectionFooterHeight = 0.1
        self.tableView.separatorStyle = .none
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedRowHeight = 0
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.contentInset = UIEdgeInsets(top: NavaBar_H, left: 0, bottom: Tabbar_H, right: 0)
        view.addSubview(self.tableView)
//        self.tableView.tableHeaderView = searchController.searchBar
        

        
        let viewNew = UIView(frame: self.tableView.bounds)
        viewNew.backgroundColor = UIColor.Gray237Color()
        self.tableView.backgroundView = viewNew
        
        // 添加毛玻璃效果
        let blur = UIBlurEffect(style: UIBlurEffect.Style.light)

        effectView = UIVisualEffectView(effect: blur)
        effectView?.frame = CGRect(x: 0, y: 0, width: Screen_W, height: NavaBar_H)
        effectView?.backgroundColor =  UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 0)
        effectView?.alpha = 1
        self.view.addSubview(effectView!)
        
        for item in effectView!.subviews {

            item.backgroundColor =  UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 0.5)
        }
        

        let viewH = 1/UIScreen.main.scale

        viewLine1 = UIView(frame: CGRect(x: 0, y: NavaBar_H-viewH, width: Screen_W, height: viewH))
        viewLine1.backgroundColor = UIColor.Gray213Color()
        viewLine1.isHidden = true
        self.view.addSubview(viewLine1)
        
        
        
        
        // 导航添加
        
        topView = UIView(frame: effectView!.bounds)
        topView.backgroundColor = UIColor.clear
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "Fav_List_Add_Icon_Normal"), for: .normal)
        rightButton.imageView?.contentMode = .scaleAspectFill
        rightButton.frame = CGRect(x: Screen_W-30 - 15, y: StatusBar_H + (44 - 30)/2, width: 30, height: 30)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rightButton.backgroundColor = UIColor.clear
        rightButton.addTarget(self, action: #selector(more), for: .touchUpInside)
        let title = UILabel(frame: CGRect(x: 0, y: StatusBar_H + (44 - 30)/2, width: Screen_W, height: 30))
        title.text = "微信"
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 17)
        topView.addSubview(title)
        topView.addSubview(rightButton)
        self.view.addSubview(topView)
        
        
        
        let backSearch = UIView(frame: CGRect(x: 0, y: 0, width: Screen_W, height: 56))
        
        backSearch.backgroundColor = UIColor.Gray237Color()
        
        searchView.frame  = CGRect(x: 10, y: 9, width: Screen_W-20, height: 38)
        searchView.searchDelegate = self
        btnCancle.frame = CGRect(x: searchView.frame.origin.x+searchView.frame.size.width, y: 0, width: 60, height: 56)
        btnCancle.setTitle("取消", for: .normal)
        btnCancle.setTitleColor(UIColor(r: 87, g: 107, b: 148), for: .normal)
        btnCancle.addTarget(self, action: #selector(btnCancleClick), for: .touchUpInside)
        backSearch.addSubview(btnCancle)
        searchView.backgroundColor = UIColor.white
        
        
        imagV = UIImageView(frame: CGRect(x: 10, y: 1, width: 16, height: 16))
        imagV.image = UIImage(named: "local_search_icon_Normal")
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        v.addSubview(imagV)
        
        searchView.leftView = v
        searchView.leftViewMode = .always
        searchView.placeholder = "搜索"
        
        btnSearch.frame = CGRect(x: 0, y: 0, width: 100, height: 38)
        btnSearch.setTitle("搜索", for: .normal)
        btnSearch.setTitleColor(UIColor(r: 199, g: 199, b: 204), for: .normal)
        btnSearch.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btnSearch.setImage(UIImage(named: "local_search_icon_Normal"), for: .normal)
        btnSearch.imageEdgeInsets = UIEdgeInsets(top: -2, left: -12, bottom: 0, right: 6)
        btnSearch.titleEdgeInsets = UIEdgeInsets(top: -2, left: -12, bottom: 0, right: 0)
        btnSearch.isHidden = true
        searchView.addSubview(btnSearch)
        
        
        
        searchView.layer.cornerRadius = 6;
        searchView.contentVerticalAlignment = .center
        backSearch.addSubview(searchView)
        tableView.tableHeaderView = backSearch

        
    
        tableViewSearch = UITableView(frame: CGRect(x: 0, y: NavaBar_H + 56, width: self.view.frame.size.width, height: self.view.frame.size.height-NavaBar_H), style: .plain)
        
        tableViewSearch.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewSearch.dataSource = self
        tableViewSearch.delegate = self
        tableViewSearch.separatorStyle = .none
        tableViewSearch.backgroundColor = UIColor.white
        tableViewSearch.contentInsetAdjustmentBehavior = .never
        tableViewSearch.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let viewNew2 = UIView(frame: self.tableView.bounds)
        viewNew2.backgroundColor = UIColor.Gray237Color()
        tableViewSearch.backgroundView = viewNew2
        
        
    }

}

extension ChatViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewSearch {
            return 1
        }
        return msgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatGoupListTableViewCell") as! ChatGoupListTableViewCell
            
            cell.textMes = msgArray[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchTableViewCell

            return cell
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewSearch {
            return Screen_H - NavaBar_H
        }
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewSearch {
            return 
        }
        let receiver : DBChat = msgArray[indexPath.row]
        
        let que = "objectId = \'\(receiver.recipientId)\'"
        let dbUsers =  RealmTool.getDBUserById(que)
        
        if dbUsers.first == nil {
            socketClient.sendFridenDetail(phone: receiver.recipientId)
            Toast.showCenterWithText(text: "好友信息暂未获取，稍后重试")
           return
        }
        
        let chatVc = ChatRoomViewController(dbUsers: dbUsers,type: .chatlist)
        self.navigationController?.pushViewController(chatVc, animated: true)

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == tableViewSearch {
            return
        }
        
        
        if scrollView.contentOffset.y > -NavaBar_H {
            self.topView.frame.origin.y = 0
        } else {
            
            topView.top = -scrollView.contentOffset.y - NavaBar_H
        }

        
        let tableHeadH : CGFloat = tableView.tableHeaderView?.height ?? 0.0
        
        let scrollsetOffY = scrollView.contentOffset.y + NavaBar_H - tableHeadH
        changeNavigation(scrollsetOffY)
        
    }
    
}


extension ChatViewController {
    
    
    // 查询数据并且刷新列表
    func searchAndReload() {
        // 查询聊天列表数据
        msgArray.removeAll()
        msgArray =  IMDataManager.share.searchRealmGroupList()
        self.tableView.reloadData()
    }
    
    @objc func updateGroupList(nofification:Notification)  {
        
        searchAndReload()
    }
    
    @objc func btnCancleClick()  {
        self.searchView.endEditing(true)
    }
    
    
}

extension ChatViewController {
    
    // 通知
    func registerNotification(){
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateGroupList(nofification:)),
                                               name: NSNotification.Name(rawValue: "GroupListSuccess"),
                                               object: nil)
        
    }
    
    
    func changeNavigation(_ offset : CGFloat)  {
        
        let tableHeadH : CGFloat = tableView.tableHeaderView?.height ?? 0.0
        effectView?.alpha = offset <= -56 ? 0 : 1
        
        viewLine1.isHidden = offset <= -tableHeadH
        if offset == -12 {
            viewLine1.isHidden = true
        }

    }
    
}



extension ChatViewController : SearchViewDelegate  {
    
    
    func searchViewShouldBeginEditing(_ searchView: UITextField) {
        self.view.addSubview(self.tableViewSearch)
        self.searchView.leftView?.isHidden = false
        self.searchView.placeholder = "搜索"
        btnSearch.frame = CGRect(x: 0, y: 0, width: 100, height: 38)
        self.btnSearch.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
            self.topView.frame.origin.y = -NavaBar_H
            self.effectView!.frame.origin.y = -NavaBar_H
            self.navigationController?.navigationBar.isHidden = true
            self.tableView.isScrollEnabled = false
            
            self.tableViewSearch.frame.origin.y = NavaBar_H+12
            self.searchView.frame  = CGRect(x: 10, y: 9, width: Screen_W-20-50, height: 38)
            
            self.btnCancle.frame = CGRect(x: self.searchView.frame.origin.x+self.searchView.frame.size.width, y: 0, width: 60, height: 56)
            
            
        }
    }
    
    func searchViewShouldEndEditing(_ searchView: UITextField) {
        self.navigationController?.navigationBar.isHidden = false
        self.tableView.isScrollEnabled = true
        self.tableViewSearch.frame.origin.y = 88+56
        self.tableViewSearch.removeFromSuperview()
        self.searchView.leftView?.isHidden = true
        self.searchView.placeholder = ""
        self.btnSearch.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.topView.frame.origin.y = 0
            self.effectView!.frame.origin.y = 0
            self.tableView.setContentOffset(CGPoint(x: 0, y: -NavaBar_H), animated: false)
            
            self.searchView.frame  = CGRect(x: 10, y: 9, width: Screen_W-20, height: 38)
            
            self.btnCancle.frame = CGRect(x: self.searchView.frame.origin.x+self.searchView.frame.size.width, y: 0, width: 60, height: 56)
            self.btnSearch.frame.origin.x = Screen_W/2 - 50-5
            
            
        }) { (finish) in
            self.btnSearch.isHidden = true
            self.tableView.contentInset = UIEdgeInsets(top: NavaBar_H, left: 0, bottom: 0, right: 0)
            self.searchView.leftView?.isHidden = false
            self.searchView.placeholder = "搜索"
        }
    }
    
    
    @objc func more() {
        
    }
    
    
    
}
