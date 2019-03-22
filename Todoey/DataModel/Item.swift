//
//  Item.swift
//  Todoey
//
//  Created by Kate on 18/3/19.
//  Copyright © 2019 Kate Guru. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated = Date()
    // declare forward relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
