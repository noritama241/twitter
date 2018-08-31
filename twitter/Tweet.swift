//
//  Tweet.swift
//  twitter
//
//  Created by 舘俊男 on 2018/08/29.
//  Copyright © 2018年 株式会社ストライド. All rights reserved.
//

import Foundation

struct Tweet {
  
  let id: String
  
  let text: String
  
  let user: User
  
  init(id: String, text: String, user: User) {
    self.id = id
    self.text = text
    self.user = user
  }
  
  init?(json: Any) {
    guard let dictionary = json as? [String: Any] else { return nil }
    
    guard let id = dictionary["id_str"] as? String else { return nil }
    guard let text = dictionary["text"] as? String else { return nil }
    guard let userJSON = dictionary["user"] else { return nil }
    guard let user = User(json: userJSON) else { return nil }
    
    self.id = id
    self.text = text
    self.user = user
  }
}
