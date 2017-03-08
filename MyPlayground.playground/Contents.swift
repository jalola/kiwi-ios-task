//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func getDayOfWeek(_ date:Double)->String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let aDate = Date(timeIntervalSince1970: date)
    let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
    let myComponents = (myCalendar as NSCalendar).components(.weekday, from: aDate)
    let weekDay = myComponents.weekday!
    
    var result = "Sunday"
    switch weekDay {
    case 2:
        result = "Monday"
    case 3:
        result = "Tuesday"
    case 4:
        result = "Wednesday"
    case 5:
        result = "Thursday"
    case 6:
        result = "Friday"
    case 7:
        result = "Saturday"
    default:
        result = "Sunday"
    }
    
    return result
}

func getDate(_ date:Double)->String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "MMMM dd yyyy"
    let aDate = Date(timeIntervalSince1970: date)

    let result = formatter.string(from: aDate)
    
    return result
}

getDayOfWeek(1490674200)
getDayOfWeek(1490680800)
getDate(1490674200)
getDate(1490680800)