//
//  ViewChatController.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import UIKit

protocol ViewChatControllerInterFace {
    func reloadData()
}

class ViewChatController: UIViewController {
    
    @IBOutlet weak var marginRightViewBackgroundTextView: NSLayoutConstraint!
    @IBOutlet private weak var btnSendMess: UIButton!
    @IBOutlet private weak var viewBackgroundTextView: UIView!
              private var presenter: ViewChatPresenter?
    @IBOutlet private weak var constrainBottomTextView: NSLayoutConstraint!
    @IBOutlet private weak var viewContentTableView: UIView!
    @IBOutlet private weak var tblViewChat: UITableView!
    @IBOutlet private weak var uitextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenterImp()
        setUp(tableView: tblViewChat, nibName: "CellChat", identifierCell: "CellChat")
        viewBackgroundTextView.layer.cornerRadius = viewBackgroundTextView.bounds.size.height/2
        
        autoAnimationHideButton()
        navigationItem.title = "Demo TweeterChat"
    }
    private func autoAnimationHideButton() {
        btnSendMess.isHidden = true
        marginRightViewBackgroundTextView.priority = UILayoutPriority(rawValue: 999.5)
       
    }
    private func autoAnimationNotHideButton() {
        btnSendMess.isHidden = false
        marginRightViewBackgroundTextView.priority = UILayoutPriority(rawValue: 998)

    }
    
    private func initPresenterImp() {
        presenter = ViewChatPresenterImp(interactor: ViewChatInteractorImp(param: "arrContent", completion: { (trueOrFalse) in
            if trueOrFalse {
                self.tblViewChat.reloadData()
                self.tblViewChat.scrollToBottom()
            }
        }), router: self, tbView: self)
    }
    
    private func setUp(tableView: UITableView, nibName: String, identifierCell: String) {
        let nib = UINib.init(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifierCell)
        tableView.separatorColor = .white
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
               autoAnimationNotHideButton()
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
            autoAnimationHideButton()
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func clickSendContentChat(_ sender: Any) {
        presenter?.sendData(from: uitextView.text, tbv: self, completion: { (string) in
            showAlert(withTitle: "Error!", withMessage: string)
        })
        uitextView.text = ""
        autoSizeFor(textView: uitextView)
        tblViewChat.reloadData()
    }
    
    private func autoSizeFor(textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
}
extension ViewChatController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
         autoSizeFor(textView: textView)
         tblViewChat.scrollToBottom()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setUpObserver()
//        autoSizeFor(textView: textView)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        setUpObserver()
//        autoSizeFor(textView: textView)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewChatController: ViewChatControllerInterFace {
    func reloadData() {
        tblViewChat.reloadData()
    }
}


