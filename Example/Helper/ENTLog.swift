//
//  ENTLog.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import Foundation

func entLog(_ item: Any) {
    #if DEBUG
        print(item)
    #endif
}
