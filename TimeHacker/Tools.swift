//
//  Tools.swift
//  TimeHacker
//
//  Created by Art on 12/14/15.
//  Copyright © 2015 Art. All rights reserved.
//

import Foundation


var isDebug: Bool {
    get {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}