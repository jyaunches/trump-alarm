//
//  GoogleCivicInfoInteractor.swift
//  trump-alarm
//
//  Created by Stephanie Guevara on 10/29/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class GoogleCivicInformationInteractor: NSObject {
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
    
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        }.resume()
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func clientURLRequest(params: Dictionary<String, String>) -> NSMutableURLRequest {
        var requestString = ""
        
        for (key, value) in params {
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let endcodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            requestString += encodedKey! + "=" + endcodedValue! + "&"
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: Environment.Path.googleCivicInfoAPIPath + "/?" + requestString + Environment.Path.googleCovovInfoAPIKeyName + "=" + Secret.googleCivicInfoAPIKey) as! URL)
        
        return request
    }

    func getPollInfo(params: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ message: AnyObject?) -> ()) {
        
        get(request: clientURLRequest(params: params), completion: { (success, object) in
            DispatchQueue.main.async {
                
                if success {
                    completion(true, object)
                } else {
                    
                    completion(false, nil)
                }
            }
        })
    }
    
}
