//
//  Encodable+Extension.swift
//  TicketSpark
//
//  Created by Apple on 08/03/24.
//

import Foundation
extension Encodable {
  func asArrayDictionary() throws -> [[String: Any]] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return [dictionary]
  }
}
