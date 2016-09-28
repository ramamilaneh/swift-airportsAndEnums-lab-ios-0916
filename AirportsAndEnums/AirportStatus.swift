//
//  AirportStatus.swift
//  AirportsAndEnums
//
//  Created by Flatiron School on 7/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class AirportStatus {
    
    fileprivate(set) var airportCode: String
    fileprivate(set) var city: String
    fileprivate(set) var delay: String
    fileprivate(set) var name: String
    fileprivate(set) var state: String
    fileprivate(set) var avgDelay: String
    fileprivate(set) var type: String
    fileprivate(set) var reason: String
    fileprivate(set) var tempF: String
    fileprivate(set) var tempFNum: Int
    fileprivate(set) var visibility: String
    fileprivate(set) var weather: String
    fileprivate(set) var windSpeed: String
    fileprivate(set) var windDirection: String
    fileprivate(set) var complete = false
    
    init(status: [String: AnyObject]) {
        
        airportCode = status["IATA"] as? String ?? "NO AIRPORT CODE"
        city = status["city"] as? String ?? "NO CITY"
        delay = status["delay"] as? String ?? "NO DELAY STATUS"
        name = status["name"] as? String ?? "NO NAME"
        state = status["state"] as? String ?? "NO STATE"
        avgDelay = status["status"]!["avgDelay"] as? String ?? "NO AVG DELAY"
        type = status["status"]!["type"] as? String ?? "NO TYPE"
        reason = status["status"]!["reason"] as? String ?? "NO REASON"
        tempF = status["weather"]!["temp"] as? String ?? "NO TEMPERATURE"
        visibility = "\(status["weather"]!["visibility"] as? Int ?? 999)"
        weather = status["weather"]!["weather"] as? String ?? "NO WEATHER"
        windSpeed = status["weather"]!["wind"] as? String ?? "NO WIND SPEED"
        windDirection = "NO WIND DIRECTION"
        tempFNum = 999
        
        editReceivedStatus()
        complete = verifyStatusComplete()
    }
    
}

// MARK: Edit/Verify Status
extension AirportStatus {
    
    func editReceivedStatus() {
        
        if delay == "true" {
            delay = "Delays"
        } else if delay == "false" {
            delay = "No delays"
        }
        
        if reason == "No known delays for this airport." {
            reason = ""
        }
        
        if tempF != "NO TEMPERATURE" {

            let tempFSplit = tempF.characters.split(separator: ".")
            tempFNum = Int(String(tempFSplit.first!))!
            tempF = "\(tempFNum)" + "° F"
            
        }
        
        if visibility != "999" {
           visibility = "Visbility: " + "\(visibility)" + "mi."
        }
        
        if windSpeed != "NO WIND SPEED" {
            let windArray = windSpeed.components(separatedBy: " ")
            if let windVelocity = windArray.last {
                let windVelocityArray = windVelocity.characters.split(separator: ".")
                windSpeed = String(windVelocityArray.first!) + "mph"
            }
            if let windAngle = windArray.first {
                windDirection = windAngle
            }
        }
    }

    func verifyStatusComplete() -> Bool {
        

        if airportCode == "NO AIRPORT CODE" {
            print("NO AIRPORT CODE")
            return false
        }
        if city == "NO CITY" {
            print("NO CITY")
            return false
        }
        if delay == "NO DELAY STATUS" {
            print("NO DELAY STATUS")
            return false
        }
        if name == "NO NAME" {
            print("NO NAME")
            return false
        }
        if state == "NO STATE" {
            print("NO STATE")
            return false
        }
        if avgDelay == "NO AVG DELAY" {
            print("NO AVG DELAY")
            return false
        }
        if type == "NO TYPE" {
            print("NO TYPE")
            return false
        }
        if reason == "NO REASON" {
            print("NO REASON")
            return false
        }
        if tempF == "NO TEMPERATURE" {
            print("NO TEMPERATURE")
            return false
        }
        if tempFNum == 999 {
            print("NO TEMP NUMBER")
            return false
        }
        if visibility == "999" {
            print("NO VISIBILITY")
            return false
        }
        if weather == "NO WEATHER" {
            print("NO WEATHER")
            return false
        }
        if windSpeed == "NO WIND SPEED" {
            print("NO WIND SPEED")
            return false
        }
        if windDirection == "NO WIND DIRECTION" {
            print("NO WIND DIRECTION")
            return false
        }
        return true
    }

}


// MARK: Test Data
extension AirportStatus {
    
    class func getTestDataDictionary() -> NSDictionary? {
        
        let airportStatusDictionary: NSMutableDictionary = [:]
        
        let statusATL: [String: AnyObject] = [
            "IATA": "ATL" as AnyObject,
            "city": "Atlanta" as AnyObject,
            "delay": "false" as AnyObject,
            "name": "Hartsfield-Jackson Atlanta International Airport" as AnyObject,
            "state": "Georgia" as AnyObject,
            "status": ["avgDelay" : "", "type": "", "reason": ""] as AnyObject,
            "weather": ["temp": "83.0 F (28.3 C)", "visibility": 10.00, "weather": "Mostly Cloudy", "wind": "North at 5.8mph"] as AnyObject]
        
        let statusDFW: [String: AnyObject] = [
            "IATA": "DFW" as AnyObject,
            "city": "Dallas" as AnyObject,
            "delay": "true" as AnyObject,
            "name": "Dallas/Ft Worth International" as AnyObject,
            "state": "Texas" as AnyObject,
            "status": ["avgDelay" : "10 minutes", "type": "Departure", "reason": "TM Initiatives:STOP:RWY"] as AnyObject,
            "weather": ["temp": "83.0 F (28.3 C)", "visibility": 10.00, "weather": "A Few Clouds", "wind": "West at 10.4mph"] as AnyObject]
        
        let statusJFK: [String: AnyObject] = [
            "IATA": "JFK" as AnyObject,
            "city": "New York" as AnyObject,
            "delay": "false" as AnyObject,
            "name": "John F Kennedy International" as AnyObject,
            "state": "New York" as AnyObject,
            "status": ["avgDelay" : "", "type": "", "reason": ""] as AnyObject,
            "weather": ["temp": "81.0 F (27.2 C)", "visibility": 2.00, "weather": "Rain", "wind": "West at 15.0mph"] as AnyObject]
        
        let statusLAX: [String: AnyObject] = [
            
            "IATA": "LAX" as AnyObject,
            "city": "Los Angeles" as AnyObject,
            "delay": "true" as AnyObject,
            "name": "Los Angeles International" as AnyObject,
            "state": "California" as AnyObject,
            "status": ["avgDelay" : "20 minutes", "type": "Thunderstorms", "reason": "TSTMS"] as AnyObject,
            "weather": ["temp": "74.0 F (23.3 C)", "visibility": 1.00, "weather": "Thunderstorm", "wind": "West at 10.4mph"] as AnyObject]
        
        let statusORD: [String: AnyObject] = [
            "IATA": "ORD" as AnyObject,
            "city": "Chicago" as AnyObject,
            "delay": "true" as AnyObject,
            "name": "Chicago OHare International" as AnyObject,
            "state": "Illinois" as AnyObject,
            "status": ["avgDelay" : "120 minutes", "type": "Emergency", "reason": "WX / EMERG"] as AnyObject,
            "weather": ["temp": "74.0 F (23.3 C)", "visibility": 8.00, "weather": "Funnel Cloud", "wind": "South at 50.5mph"] as AnyObject]
        
        let statusArray = [statusATL, statusDFW, statusJFK, statusLAX, statusORD]
    
        for status in statusArray {
            let airportStatus = AirportStatus(status: status)
            airportStatusDictionary[airportStatus.airportCode] = airportStatus
        }
        
        return airportStatusDictionary
        
    }
    
}







































