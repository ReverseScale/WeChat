//
//  ChatRoomViewController.swift
//  WeChat
//
//  Created by panzhijun on 2019/5/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

import UIKit
import RealmSwift

class ChatRoomViewController: BaseViewController {

    
    // tableView
    open lazy var tableView : UITableView = {
        let tableView =  UITableView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: Screen_W,
                                                   height: Screen_H),
                                     style: UITableView.Style.plain)
        
        return tableView
    }()

    open var dbUsers : Results<DBUser>?
    
    fileprivate var chatRoomVM : ChatRoomViewModel = ChatRoomViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = dbUsers?.first?.name
        
        effectView!.alpha = 0.9

        viewLine1.isHidden = false
       
        self.view.backgroundColor = UIColor.white
        setup()
    }
    
    
    init(dbUsers : Results<DBUser>) {
        
        super .init(nibName: nil, bundle: nil)
        self.dbUsers = dbUsers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.chatRoomVM.registerNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.chatRoomVM.removeNotification()
        
    }

}

extension ChatRoomViewController {
    
    func setup()  {
        
        self.view.insertSubview(self.tableView, belowSubview: self.effectView!)
        chatRoomVM.bingData(data: (self.dbUsers?.first)!)
        chatRoomVM.bindVC(vc: self)
        chatRoomVM.bindTablView(tableView: self.tableView)
        chatRoomVM.loadDataRequest()
        
    }
   
    
}

// MARK:- 键盘通知
extension ChatRoomViewController {
   
    
}
