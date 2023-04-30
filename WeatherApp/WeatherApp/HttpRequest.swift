//
//  HttpRequest.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 29.04.2023.
//

import Foundation
import UIKit

class HttpRequest {
    
    let api_Key = "aa43ddbf669e763f88336491f2193c08"
    let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    
    func getCurrentWeatherData(lat: Double, lon: Double,completion: @escaping (Result?, Error?) -> Void) {
        
        
        let currentWeatherApi = baseUrl + "weather?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        let air_pollution = baseUrl + "air_pollution?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        let forecast = baseUrl + "forecast?lat=\(lat)&lon=\(lon)&appid=\(api_Key)"
        
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
    
    func getIconImage(with imageString: String) -> UIImage{
        
        var iconImage = UIImage()
        
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(imageString)@2x.png") else {
            fatalError("Invalid URL")
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }

            guard let data = data, let image = UIImage(data: data) else {
                fatalError("Invalid image data")
            }

            DispatchQueue.main.async {
                // UIImageView'in image özelliğine yüklemek için
                iconImage = image
            }
        }
        task.resume()
        return iconImage
        
    }
}
