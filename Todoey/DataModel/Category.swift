//
//  Category.swift
//  Todoey
//
//  Created by Kate on 18/3/19.
//  Copyright © 2019 Kate Guru. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
}
