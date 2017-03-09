//
//  Helper.swift
//  KiwiPopularDes
//
//  Created by Hung Nguyen on 3/8/17.
//  Copyright © 2017 Hung Nguyen. All rights reserved.
//

import Foundation
import UIKit

open class Helper {
    
    open class func getCurrencySymbol(currency: String) -> String{
        if currency == "EUR"{
            return "€"
        }
        else{
            return "no currency"
        }
    }
    
    
    open class func getDayOfWeek(_ date:Double)->String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let aDate = Date(timeIntervalSince1970: date)
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components(.weekday, from: aDate)
        let weekDay = myComponents.weekday!
        
        var result = "Sun"
        switch weekDay {
        case 2:
            result = "Mon"
        case 3:
            result = "Tue"
        case 4:
            result = "Wed"
        case 5:
            result = "Thu"
        case 6:
            result = "Fri"
        case 7:
            result = "Sat"
        default:
            result = "Sun"
        }
        
        return result
    }
    
    open class func getTime(_ date:Double)->String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let aDate = Date(timeIntervalSince1970: date)
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components([.hour, .minute, .second], from: aDate)
        
        if myComponents.minute! >= 10{
            return "\(myComponents.hour!):\(myComponents.minute!)"
        }
        else{
            return "\(myComponents.hour!):0\(myComponents.minute!)"
        }
    }
    
    open class func getDate(_ date:Double)->String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        let aDate = Date(timeIntervalSince1970: date)
        
        let result = formatter.string(from: aDate)
        
        return result
    }
    
    open class func getDateForAPI(offset: Int, sep: String)->String {
        let date = Calendar.current.date(byAdding: .day, value: offset, to: Date())!
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd\(sep)MM\(sep)yyyy"
        let result = formatter.string(from: date)
        
        return result
    }
    
    open class func writeFile(_ fileName: String, text: String) -> Void{
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            print(path)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    open class func readFile(_ fileName: String) -> String{
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            print(path)
            
            //reading
            do {
                let text = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
                return text as String
            }
            catch {/* error handling here */
                return ""
            }
        }
        
        return ""
    }

    open class func jsonToString(json: [String:Any]) -> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            return convertedString!
            
        } catch let myJSONError {
            print(myJSONError)
            return ""
        }
    }
    
    open class func stringToJson(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
