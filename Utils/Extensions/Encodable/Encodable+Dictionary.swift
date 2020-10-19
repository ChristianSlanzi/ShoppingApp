//
//  Encodable+Dictionary.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

public extension Encodable {
  var dictionaryRepresentation: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }

    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
      .flatMap { $0 as? [String: Any] }
  }
}
