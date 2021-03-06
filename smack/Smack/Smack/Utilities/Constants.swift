//
//  Constants.swift
//  Smack
//
//  Created by imac on 5/5/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//EndP
//let BASE_URL = "http://localhost:3005/v1/"
let BASE_URL = "https://smackcool.herokuapp.com/v1/"

let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//Notification
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsIsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")

//Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 1)

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
