//
//  HttpRequest.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 29.04.2023.
//

import Foundation
import UIKit
import CoreLocation

class HttpRequest {
    
    let api_Key = "aa43ddbf669e763f88336491f2193c08"
    let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    func getLocation() -> (Double,Double){
        
        let vc = ViewController()
        
        let lat = vc.findLocation().coordinate.latitude
        let lon = vc.findLocation().coordinate.longitude
        
        return (lat,lon)
    }
    
    func getCurrentWeatherData(completion: @escaping (Result?, Error?) -> Void) {
        
        let lat = getLocation().0
        let lon = getLocation().1
      
        let currentWeatherApi = baseUrl + "weather?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
       
        guard let url = URL(string: currentWeatherApi) else {
                fatalError("Failed to create URL.")
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(nil, error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                    completion(nil, error)
                    return
                }

                guard let data = data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(nil, error)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Result.self, from: data)
                    // Verileriniz artık "result" adlı değişkende tutuluyor.
                    completion(result, nil)
                    
                } catch {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    
    
    func forecastResult (completion: @escaping (ResultForeCast?, Error?) -> Void) {
        
        let lat = getLocation().0
        let lon = getLocation().1
        
        let forecast = baseUrl + "forecast?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        
        guard let url = URL(string: forecast) else {
                fatalError("Failed to create URL.")
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(nil, error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                    completion(nil, error)
                    return
                }

                guard let data = data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(nil, error)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ResultForeCast.self, from: data)
                    // Verileriniz artık "result" adlı değişkende tutuluyor.
                    completion(result, nil)
                    
                } catch {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    
    func getAirPollutionData(completion: @escaping (ResultAirPollution?, Error?) -> Void) {
        
        let lat = getLocation().0
        let lon = getLocation().1
        
        let air_pollution = baseUrl + "air_pollution?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        
        guard let url = URL(string: air_pollution) else {
                fatalError("Failed to create URL.")
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(nil, error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                    completion(nil, error)
                    return
                }

                guard let data = data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(nil, error)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ResultAirPollution.self, from: data)
                    // Verileriniz artık "result" adlı değişkende tutuluyor.
                    completion(result, nil)
                    
                } catch {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    
    
    func getIconImage(imageString: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(imageString)@2x.png") else {
            fatalError("Invalid URL")
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }

            guard let data = data else {
                fatalError("Invalid image data")
            }

            completion(data)
        }
        task.resume()
    }
}
