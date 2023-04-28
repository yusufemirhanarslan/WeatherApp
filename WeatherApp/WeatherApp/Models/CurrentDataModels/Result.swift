//
//  Result.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 28.04.2023.
//

import Foundation


struct Result:Codable {
    
    let coord: CoordModel?
    let weather: [WeatherModel?]
    let base: String?
    let main: MainModel?
    let visibility: Int?
    let wind: WindModel?
    let clouds: CloudsModel?
    let dt: Int?
    let sys: SystemModel?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
}
