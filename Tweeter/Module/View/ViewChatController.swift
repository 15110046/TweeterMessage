//
//  ViewChatController.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import UIKit

class ViewChatController: UIViewController {
    
    @IBOutlet weak var viewBackgroundTextView: UIView!
    private var presenter: ViewChatPresenter?
    
    @IBOutlet private weak var constrainBottomTextView: NSLayoutConstraint!
    @IBOutlet private weak var viewContentTableView: UIView!
    @IBOutlet private weak var tblViewChat: UITableView!
    @IBOutlet private weak var uitextView: UITextView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ViewChatPresenterImp(interactor: ViewChatInteractorImp(param: "arrContent", completion: { (trueOrFalse) in
            if trueOrFalse {
                self.tblViewChat.reloadData()
                self.tblViewChat.scrollToBottom()
            }
        }), router: self, tbView: self)
        uitextView.delegate = self
        uitextView.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        let nib = UINib.init(nibName: "CellChat", bundle: nil)
        tblViewChat.register(nib, forCellReuseIdentifier: "CellChat")
        tblViewChat.separatorColor = .white
        viewBackgroundTextView.layer.cornerRadius = viewBackgroundTextView.bounds.size.height/2
    }
    private func setUpObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    @objc fileprivate func keyboardWillShow(notification:NSNotification) {
        if let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardRectValue.height
            constrainBottomTextView.constant = keyboardHeight
            tblViewChat.scrollToBottom()
            if uitextView.text == "Bắt đầu một tin nhắn" {
                uitextView.text = ""
            }
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc fileprivate func keyboardWillHide(notification:NSNotification) {
        constrainBottomTextView.constant = 0
        tblViewChat.scrollToBottom()
        if uitextView.text == "" {
            uitextView.text = "Bắt đầu một tin nhắn"
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func clickSendContentChat(_ sender: Any) {
        presenter?.sendData(from: uitextView.text, tbv: self, completion: { (string) in
            print(string)
        })
//        if uitextView.text.checkAllCharacterSpace() { return }
        uitextView.text = ""
        tblViewChat.reloadData()
    }
}
extension ViewChatController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textViewDidChange(_ textView: UITextView) {
     
        let size = CGSize(width: view.frame.width - 44, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
                tblViewChat.scrollToBottom()
            }
        }
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setUpObserver()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        setUpObserver()
        return true
    }
    
}

extension ViewChatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataForRow = presenter?.dataForRow(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellChat", for: indexPath) as? CellChat
            else { return UITableViewCell() }
        cell.config(contentCell: dataForRow[indexPath.row].contentChat)
        return cell
    }
    
}
extension ViewChatController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

protocol UpdataUITableView {
    func reloadData()
}
extension ViewChatController: UpdataUITableView{
    func reloadData() {
        tblViewChat.reloadData()
    }
}

