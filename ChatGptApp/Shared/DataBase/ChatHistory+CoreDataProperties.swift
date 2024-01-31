//
//  ChatHistory+CoreDataProperties.swift
//  
//
//  Created by Ankush Dhawan on 30/01/24.
//
//

import Foundation
import CoreData


extension ChatHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatHistory> {
        return NSFetchRequest<ChatHistory>(entityName: "ChatHistory")
    }

    @NSManaged public var isInteractingWithChatGPT: Bool
    @NSManaged public var sendImage: String?
    @NSManaged public var sendText: String?
    @NSManaged public var responseImage: String?
    @NSManaged public var responseText: String?
    @NSManaged public var responseError: String?
    @NSManaged public var chatDate: Date?

}
