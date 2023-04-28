//
//  ListModel.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 29.04.2023.
//

import Foundation

struct ListModel:Codable {
    
    let main: AirPollutionMainModel?
    let components: ComponentsModel?
    let dt: Int?
    
}
