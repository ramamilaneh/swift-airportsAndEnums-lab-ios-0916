//
//  ForecastAPI.swift
//  AirportsAndEnums
//
//  Created by Flatiron School on 7/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class FAAServicesAPI {
    
    class func getAirportStatusForAirports(_ airportCodes: [String], completionHandler: @escaping (_ status: NSDictionary?) -> Void) {
        
        let airportDict: NSMutableDictionary = [:]
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
//        global(priority: DispatchQueue.GlobalQueuePriority.default)
        
        for airportCode in airportCodes {
            group.enter()
            queue.async(execute: { 
                getStatusForAirport(airportCode, completionHandler: { status in
                    if let aStatus = status {
                        airportDict[aStatus.airportCode] = aStatus
                    }
                    group.leave()
                })
            })
        }
        
        group.notify(queue: queue) {
            if airportDict.count == airportCodes.count {
                completionHandler(airportDict)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    class func getStatusForAirport(_ airportCode: String, completionHandler: @escaping (_ status: AirportStatus?) -> Void) {
        
        let statusEndpoint = "http://services.faa.gov/airport/status/" + airportCode + "?format=application/json"
        
        guard let url = URL(string: statusEndpoint) else {
            print("Error: cannot create URL")
            completionHandler(nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if data == nil {
                completionHandler(nil)
                return
            }
            
            do {
                if let status = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                    
                    let airportStatus = AirportStatus(status: status)
                    if airportStatus.complete {
                        completionHandler(airportStatus)
                    } else {
                        print("Error: data received is not valid")
                        completionHandler(nil)
                    }
                    
                }
                
            } catch {
                print("Error: cannot get JSON data")
                completionHandler(nil)
                
            }
        }) .resume()
        
    }
    
}

