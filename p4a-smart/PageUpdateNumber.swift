//
//  PageUpdateNumber.swift
//  p4a-smart
//
//  Created by Weicheng Zhu on 12/18/15.
//  Copyright © 2015 Weicheng Zhu. All rights reserved.
//

import Foundation
import RealmSwift

class PageUpdateNumber:  Object{
    
    dynamic var number = ""
    dynamic var owner: TextPrinterData?
    
}