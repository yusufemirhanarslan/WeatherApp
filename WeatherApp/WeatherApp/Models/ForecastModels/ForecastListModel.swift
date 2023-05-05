//
//  ForecastListModel.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 30.04.2023.
//

import Foundation

struct ForecastListModel:Codable {
    
    let dt: Int?
    let main: ForeCastMainModel?
    let weather: [WeatherModel?]
    let clouds: CloudsModel?
    let wind: WindModel?
    let visibility: Int?
    let pop: Double?
    let sys: ForeCastSysModel?
    let dt_txt: String?
}
