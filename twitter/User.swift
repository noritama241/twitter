//
//  User.swift
//  twitter
//
//  Created by 舘俊男 on 2018/08/28.
//  Copyright © 2018年 株式会社ストライド. All rights reserved.
//

import Foundation

struct User {
  
  let id: String
  
  let screenName: String
  
  let name: String
  
  let profileImageURL: String
  
  init?(json: Any) {
    guard let dictionary = json as? [String: Any] else { return nil }
    
    guard let id = dictionary["id_str"] as? String else { return nil }
    guard let screenName = dictionary["screen_name"] as? String else { return nil }
    guard let name = dictionary["name"] as? String else { return nil }
    guard let profileImageURL = dictionary["profile_image_url_https"] as? String else { return nil }
    
    self.id = id
    self.screenName = screenName
    self.name = name
    self.profileImageURL = profileImageURL
  }
}
