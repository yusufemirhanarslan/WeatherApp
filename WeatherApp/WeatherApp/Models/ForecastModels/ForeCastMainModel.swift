//
//  ForeCastMainModel.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 30.04.2023.
//

import Foundation

struct ForeCastMainModel:Codable{
    
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let sea_level: Double?
    let grnd_level: Double?
    let humidity: Double?
    let temp_kf: Double?
}
