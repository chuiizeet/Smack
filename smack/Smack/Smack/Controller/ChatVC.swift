//
//  ChatVC.swift
//  Smack
//
//  Created by imac on 5/4/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func userDataChanged(_ notif: Notification) {
        
        if AuthService.instance.isLoggedIn {
            onLogginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channel = MessageService.instance.selectChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channel)"
        getMessages()
    }
    
    func onLogginGetMessages() {
        MessageService.instance.findAllChannel {(success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channel yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId){(success) in
            
        }
    }
    
    
    

}
