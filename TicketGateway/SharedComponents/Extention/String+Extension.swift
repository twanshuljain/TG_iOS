//
//  String+Extension.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import Foundation
import UIKit

extension String {
    public func trim() -> String {
       return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func timeStampToString(timeStamp: Double) -> (strdate: String, strtime: String)? {
        let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss a"
        timeFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeString = timeFormatter.string(from: date as Date)
        return (dateString, timeString)
    }
    
    var toDouble: Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0.0
    }
   
    var toInt: Int {
        return NumberFormatter().number(from: self)?.intValue ?? 0
    }
}

extension UITableViewCell {
    func timeStampToDateTimeString(timeStamp: Double) -> String {
           let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss a"
           dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
           let dateString = dateFormatter.string(from: date as Date)
           return dateString
       }
  public func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertTimeFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertOnlyMinutesFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
}

extension Date {
    var workoutStartTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        return dateFormatter.string(from: self)
    }
    
    var workoutEndTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        return dateFormatter.string(from: self)
    }
}

extension UIViewController {
    public func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    
    public func getTime(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm a"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    
    public func convertTimeFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm:ss"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertOnlyMinutesFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertTimeHHMMSSFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm:ss"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
}
