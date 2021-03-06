//
//  MomentsTableViewCell.swift
//  WeChat
//
//  Created by panzhijun on 2019/7/9.
//  Copyright © 2019 panzhijun. All rights reserved.
//

import UIKit

class MomentsTableViewCell: UITableViewCell {

    var imageHead = UIImageView()
    
    var nameLabel = UILabel()
    
    var contentLabel = AtrributeLabel()
    
    
    var imageBackView = UIView()
    
    var timeLabel = UILabel()
    var addressLabel = UILabel()
    
    var moreBtn = UIButton()
    var viewLine1 = UIView()
    var commentView = UIImageView()
    
    var triangleView = UIView()
    var commLabel = UILabel()
    var collectionView : UICollectionView?
    var flowLayout: UICollectionViewFlowLayout?
    
    var coverView = UIView()
    var moreImageView = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView()  {
        
        let cellMargin : CGFloat = 10
        // 头像
        imageHead.frame = CGRect(x: cellMargin, y:cellMargin , width: 45, height: 45)
        imageHead.backgroundColor = UIColor.lightGray
        imageHead.layer.cornerRadius = 5
        imageHead.layer.masksToBounds = true
        contentView.addSubview(imageHead)
        
        // 昵称
        nameLabel.frame = CGRect(x: imageHead.right + cellMargin, y: cellMargin, width: Screen_W-imageHead.right - cellMargin*2, height: 18)
        nameLabel.textColor = UIColor.init(r: 87, g: 107, b: 149)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        contentView.addSubview(nameLabel)
        
        // 内容
        contentLabel.frame = CGRect(x: nameLabel.left, y: nameLabel.bottom+10 , width: Screen_W-imageHead.right - cellMargin*2, height: 18)
        contentLabel.textColor = UIColor.black
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        contentView.addSubview(contentLabel)
        // 图片视图
        imageBackView.frame = CGRect(x: contentLabel.left, y: contentLabel.bottom+10, width:  Screen_W-imageHead.right - cellMargin*2, height: 100)
        imageBackView.backgroundColor = UIColor.lightGray
        contentView.addSubview(imageBackView)
        
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.scrollDirection = .vertical
        
        let spacing: CGFloat = 5
        let viewW = 60
        flowLayout!.minimumLineSpacing = spacing
        flowLayout!.minimumInteritemSpacing = spacing
        flowLayout!.itemSize = CGSize(width: viewW, height: viewW)

        // 图片collectionview
        collectionView = UICollectionView(frame: imageBackView.bounds, collectionViewLayout: flowLayout!)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MomentsImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.isScrollEnabled = false
        imageBackView.addSubview(collectionView!)
    
        // 地址
        addressLabel.frame = CGRect(x: imageHead.right + cellMargin, y: imageBackView.bottom+10, width: Screen_W-imageHead.right - cellMargin*2, height: 14)
        addressLabel.textColor = UIColor.init(r: 87, g: 107, b: 149)
        addressLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(addressLabel)
        
        
        // 时间
        timeLabel.frame = CGRect(x: imageHead.right + cellMargin, y: addressLabel.bottom+5, width: Screen_W-imageHead.right - cellMargin*2, height: 18)
        timeLabel.textColor = UIColor.init(r: 178, g: 178, b: 178)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(timeLabel)
        
        // 赞评论
        moreImageView = UIImageView(frame: CGRect(x: Screen_W-15-32, y: addressLabel.bottom, width: 120, height: 35))
        var imagea = UIImage(named: "ShakeCard")
        imagea = imagea?.stretchableImage(withLeftCapWidth: 10, topCapHeight: 10)
        moreImageView.image = imagea
        contentView.addSubview(moreImageView)
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 35))
        leftBtn.setTitle(" 赞", for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        leftBtn.setImage(UIImage(named: "AlbumDetailsPgeLike"), for: .normal)
        moreImageView.addSubview(leftBtn)
        
        let rightBtn = UIButton(frame: CGRect(x: 60, y: 0, width: 60, height: 35))
        rightBtn.setTitle(" 评论", for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        rightBtn.setImage(UIImage(named: "AlbumDetailsPgeSingle"), for: .normal)
        moreImageView.addSubview(rightBtn)
        
        // 遮罩 赞 评论
        coverView = UIView(frame: CGRect(x: Screen_W-15-32, y: addressLabel.bottom, width: 47, height: 35))
        coverView.backgroundColor = UIColor.white
        contentView.addSubview(coverView)
        
        
        // 分割线
        let viewLine2 = UIView(frame: CGRect(x: 60, y: 10, width: 1/UIScreen.main.scale, height:15 ))
        viewLine2.backgroundColor = UIColor.black
        moreImageView.addSubview(viewLine2)
        
        // 更多按钮
        moreBtn.frame = CGRect(x: Screen_W-15-32, y: addressLabel.bottom, width: 32, height: 20)
        moreBtn.setImage(UIImage.init(named: "AlbumOperateMore"), for: UIControl.State.normal)
        moreBtn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
        contentView.addSubview(moreBtn)
        
        // 评论
        commentView.frame = CGRect(x: imageHead.right + cellMargin, y:addressLabel.bottom+5 , width: Screen_W-imageHead.right - cellMargin*2, height: 45)
        commentView.backgroundColor = UIColor.init(r: 243, g: 243, b: 243)
        contentView.addSubview(commentView)
        
        //三角
        triangleView = UIView(frame: CGRect(x: 10, y: -3, width: 10, height: 10))
        triangleView.backgroundColor =  UIColor.init(r: 243, g: 243, b: 243)
        triangleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
        commentView.addSubview(triangleView)
        
        
        commLabel.frame = CGRect(x: 10, y: 5, width: Screen_W-imageHead.right - cellMargin*2-20, height: 14)
        commLabel.textColor = UIColor.black
        commLabel.font = UIFont.systemFont(ofSize: 14)
        commLabel.numberOfLines = 0
        commentView.addSubview(commLabel)
        
        // 分割线
        let viewH = 1/UIScreen.main.scale
        viewLine1 = UIView(frame: CGRect(x: 0, y: 100, width: Screen_W, height: viewH))
        viewLine1.backgroundColor = UIColor.Gray213Color()
        contentView.addSubview(viewLine1)
        
    }
    
    @objc func btnClick()  {
        
        UIView.animate(withDuration: 0.3) {
            
            if self.moreImageView.left == Screen_W - 15 - 32 - 120 - 10 {
               self.moreImageView.left = Screen_W - 15 - 32 
            } else {
                self.moreImageView.left = Screen_W - 15 - 32 - 120 - 10
            }

        }
       
    }

}
