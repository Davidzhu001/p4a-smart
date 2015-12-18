//
//  PrinterInfoModel.swift
//  publish4AllUtilityTools
//
//  Created by ZhuWeicheng on 9/21/15.
//  Copyright © 2015 Zhu,Weicheng. All rights reserved.
//

import RealmSwift
import Foundation

class TextPrinterData: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var pageNumber = ""
    let addingPage = List<PageUpdateNumber>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}