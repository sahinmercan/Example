//
//  String+Extension.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var stringValue: String {
        return self ?? ""
    }
    
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension String {
    func trimWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func trimWhiteSpaceAndNewLines() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removeWhiteSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
