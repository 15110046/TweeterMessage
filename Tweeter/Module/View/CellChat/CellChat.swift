//
//  CellChat.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import UIKit

class CellChat: UITableViewCell {
    private var viewBackgroundContentChat: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#0084FF", alpha: 1)
        return view
    }()
    private var lblContentCell: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
//    @IBOutlet weak var lblContentCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoLayoutviewBackgroundContentChat()
        autoLayoutlblContentChat()
    }
    func autoLayoutviewBackgroundContentChat() {
        contentView.addSubview(viewBackgroundContentChat)
        viewBackgroundContentChat.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        viewBackgroundContentChat.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        viewBackgroundContentChat.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        viewBackgroundContentChat.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        viewBackgroundContentChat.layoutIfNeeded()
        viewBackgroundContentChat.layer.cornerRadius = viewBackgroundContentChat.bounds.size.height/18
    }
    func autoLayoutlblContentChat() {
        viewBackgroundContentChat.addSubview(lblContentCell)
        lblContentCell.topAnchor.constraint(equalTo: viewBackgroundContentChat.topAnchor, constant: 5).isActive = true
        lblContentCell.bottomAnchor.constraint(equalTo: viewBackgroundContentChat.bottomAnchor, constant: -5).isActive = true
        lblContentCell.rightAnchor.constraint(equalTo: viewBackgroundContentChat.rightAnchor, constant: -10).isActive = true
        lblContentCell.leftAnchor.constraint(equalTo: viewBackgroundContentChat.leftAnchor, constant: 10).isActive = true
    }
    func config(contentCell: String?) {
        lblContentCell.text = contentCell
        
    }
}
