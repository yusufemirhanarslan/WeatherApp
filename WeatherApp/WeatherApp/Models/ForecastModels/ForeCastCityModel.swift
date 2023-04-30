//
//  ForeCastCityModel.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 30.04.2023.
//

import Foundation

struct ForeCastCityModel:Codable {
        
    let id: Int?
    let name: String?
    let coord: CoordModel?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}
