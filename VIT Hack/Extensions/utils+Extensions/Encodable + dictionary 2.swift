//
//  Encodable + dictionary.swift
//  VIT Hack
//
//  Created by Garima Bothra on 16/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
