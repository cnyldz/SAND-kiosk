//
//  Item.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
