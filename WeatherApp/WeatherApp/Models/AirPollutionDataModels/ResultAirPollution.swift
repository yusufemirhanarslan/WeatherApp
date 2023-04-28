//
//  ResultAirPollution.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 29.04.2023.
//

import Foundation

struct ResultAirPollution:Codable{
    
    let coord: CoordModel?
    let list: [ListModel?]
}
