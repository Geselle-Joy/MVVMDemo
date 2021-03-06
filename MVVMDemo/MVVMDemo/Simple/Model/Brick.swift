//
//  Brick.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import Foundation
import ObjectMapper

struct Brick: Equatable, Mappable {
    
    var id: String          = ""
    var createdAt: Date     = Date()
    var desc: String        = ""
    var publishedAt: Date   = Date()
    var source: String      = ""
    var type: String        = ""
    var url: String         = ""
    var used: String        = ""
    var who: String         = ""
    var images: [String]    = []
    
    public static func == (lhs: Brick, rhs: Brick) -> Bool {
        return lhs.id == rhs.id ? true : false
    }
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        createdAt <- map["createdAt"]
        desc <- map["desc"]
        publishedAt <- map["publishedAt"]
        source <- map["source"]
        type <- map["type"]
        url <- map["url"]
        used <- map["used"]
        who <- map["who"]
        images <- map["images"]
    }
}

struct HomeSection {
    var items: [Item]
}

extension HomeSection {
    
    typealias Item = Brick
    
    init(original: HomeSection, items: [HomeSection.Item]) {
        self = original
        self.items = items
    }
}
