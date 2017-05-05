//
//  String+Extension.swift
//  pokedexx
//
//  Created by binsnoel on 05/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

extension String {
    var condensedWhitespace: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
