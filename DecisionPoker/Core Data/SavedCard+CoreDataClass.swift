//
//  SavedCard+CoreDataClass.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 08.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SavedCard)
public class SavedCard: NSManagedObject {
    
    
    public var wrappedCardName: String {
          cardName ?? ""
      }
    
    public var wrappedCardComment: String {
          cardComment ?? ""
      }
    
    

}
