//
//  FileManager.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import Foundation

extension FileManager {
    public static func documentURL() -> URL? {
        return documentURL(childPath: nil)
    }
    
    public static func documentURL(childPath: String?) -> URL? {
        if let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if let path = childPath {
                return docURL.appendingPathComponent(path)
            }
            return docURL
        }
        return nil
    }
}
