//
//  MainModel.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 28.04.2023.
//

import Foundation

struct MainModel:Codable {
    
   let temp: Double?
   let feels_like: Double?
   let temp_min: Double?
   let temp_max: Double?
   let pressure: Double?
   let humidity: Double?
   let sea_level: Double?
   let grnd_level: Double?
}
