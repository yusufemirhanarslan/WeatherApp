//
//  HttpRequest.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 29.04.2023.
//

import Foundation


class HttpRequest {
    
    let api_Key = "YOUR_API_KEY"
    let lat = "40.662722"
    let lon = "29.307784"
    let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    
    func getCurrentWeatherData(completion: @escaping (ResultAirPollution?, Error?) -> Void) {
        
        let currentWeatherApi = baseUrl + "weather?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        let air_pollution = baseUrl + "air_pollution?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        let forecast = baseUrl + "forecast?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        
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
    
}
