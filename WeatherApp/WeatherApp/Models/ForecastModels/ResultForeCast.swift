//
//  ResultForeCast.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 30.04.2023.
//

import Foundation

struct ResultForeCast:Codable {
    
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [ForecastListModel?]
    let city: ForeCastCityModel?
}


