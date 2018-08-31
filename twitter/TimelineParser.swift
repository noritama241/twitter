//
//  TimelineParser.swift
//  twitter
//
//  Created by 舘俊男 on 2018/08/31.
//  Copyright © 2018年 株式会社ストライド. All rights reserved.
//

import Foundation

struct TimelineParser {
  func parse(data: Data) -> [Tweet] {
    let serializedData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
    
    let json = serializedData as! [Any]
    
    let timeline: [Tweet] = json.flatMap {
      Tweet(json: $0)
    }
    
    return timeline
  }
}
