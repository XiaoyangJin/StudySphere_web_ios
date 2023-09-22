//
//  Post.swift
//  StudyTogether
//
//  Created by Team 24 on 4/17/23.
//

import Foundation
import ParseSwift

struct Post: ParseObject {
    // required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // custom properties
    var user: User?
    var title: String?
    var desc: String?
    var body: String?
    var imageFile: ParseFile?
}
