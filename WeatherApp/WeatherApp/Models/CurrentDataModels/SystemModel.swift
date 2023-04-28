//
//  SystemModel.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 29.04.2023.
//

import Foundation

struct SystemModel:Codable {
    
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
