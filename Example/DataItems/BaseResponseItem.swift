//
//  BaseResponseItem.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//
import Foundation

open class BaseResponseItem: BaseItem {
    public var status_message: String = ""
    public var status_code = 200
    var isSuccess: Bool {
        get {
            return status_code == 200
        }
    }
}
