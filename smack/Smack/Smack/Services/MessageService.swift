//
//  MessageService.swift
//  Smack
//
//  Created by imac on 5/8/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                if let json = JSON(data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                if let json = JSON(data).array {
                    for item in json {
                        
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message()
                        message.channelId = channelId
                        message.id = id
                        message.message = messageBody
                        message.timeStamp = timeStamp
                        message.userAvatar = userAvatar
                        message.userAvatarColor = userAvatarColor
                        message.userName = userName
                        
                        self.messages.append(message)

                    }
                    
                    print(self.messages)
                    completion(true)
                    
                }
                
                
            } else {
                debugPrint("Error Messages!")
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
        
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
}
