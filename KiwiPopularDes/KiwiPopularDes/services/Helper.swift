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
        
        if myComponents.minute != 0{
            return "\(myComponents.hour!):\(myComponents.minute!)"
        }
        else{
            return "\(myComponents.hour!):00"
        }
    }
    
    open class func getDate(_ date:Double)->String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        let aDate = Date(timeIntervalSince1970: date)
        
        let result = formatter.string(from: aDate)
        
        return result
    }
    
}

