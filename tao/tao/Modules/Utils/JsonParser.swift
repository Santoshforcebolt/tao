//
//  JsonParser.swift
//  tao
//
//  Created by Mayank Khursija on 29/06/22.
//

import Foundation

class JsonParser {
    
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
       if let data = text.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               return json
           } catch {
               print("Something went wrong")
           }
       }
       return nil
   }
}
