//
//  Path.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

//TODO: Refactor strings
enum PathError: Error, LocalizedError {
    case notFound
    case containerNotFound(String)
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Resource not found"
        case .containerNotFound(let id): return "Shared container for group \(id) not found"
        }
    }
}

class Path {
    static func inLibrary(_ name: String) throws -> URL {
        return try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(name)
    }
    
    static func inDocuments(_ name: String) throws -> URL {
      return try FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent(name)
    }
    
    static func inBundle(_ name: String) throws -> URL {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else { throw PathError.notFound }
        return url
    }
    
    static func inSharedContainer(_ name: String, groupId: String) throws -> URL {
        guard let url = FileManager.default
          .containerURL(forSecurityApplicationGroupIdentifier: groupId) else {
            throw PathError.containerNotFound(groupId)
        }
        return url.appendingPathComponent(name)
    }
    
    static func documents() throws -> URL {
      return try FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
}
