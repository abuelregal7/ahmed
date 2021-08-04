//
//  AppData.swift
//  Task
//
//  Created by Ahmed on 8/3/21.
//

import Foundation
import RealmSwift

class AppData: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var desc: String?
    @objc dynamic var photoData: Data? = nil
//    var picture: Data?
//    @objc dynamic var picture2: Data? = nil
    //@objc dynamic var image: Data?
    
}
