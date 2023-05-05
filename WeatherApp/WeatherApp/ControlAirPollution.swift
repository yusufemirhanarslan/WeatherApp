//
//  ControlAirPollution.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 3.05.2023.
//

import Foundation

enum AirPollutionName {
    case Good
    case Fair
    case Moderate
    case Poor
    case Very_Poor
}

class ControlAirPollution {
    
    static func so2Control(so2: Double) -> (AirPollutionName,Int){
        let percent = Int((so2 / 350) * 100)
        switch so2 {
        case 0...20:
            return (AirPollutionName.Good,percent)
        case 20...80:
            return (AirPollutionName.Fair,percent)
        case 80...250:
            return (AirPollutionName.Moderate,percent)
        case 250...350:
            return (AirPollutionName.Poor,percent)
        default:
            return (AirPollutionName.Very_Poor,percent)
        }
        
    }
    
    static func no2Control(no2: Double) -> (AirPollutionName,Int){
        let percent = Int((no2 / 250) * 100)
        switch no2 {
        case 0...40:
            return (AirPollutionName.Good,percent)
        case 40...70:
            return (AirPollutionName.Fair,percent)
        case 70...150:
            return (AirPollutionName.Moderate,percent)
        case 150...200:
            return (AirPollutionName.Poor,percent)
        default:
            return (AirPollutionName.Very_Poor,percent)
        }
        
    }
    static func pm10Control(pm10: Double) -> (AirPollutionName,Int){
        let percent = Int((pm10 / 250) * 100)
        switch pm10 {
        case 0...20:
            return (AirPollutionName.Good,percent)
        case 20...50:
            return (AirPollutionName.Fair,percent)
        case 50...100:
            return (AirPollutionName.Moderate,percent)
        case 100...200:
            return (AirPollutionName.Poor,percent)
        default:
            return (AirPollutionName.Very_Poor,percent)
        }
        
    }
    static func pm2_5Control(pm2_5: Double) -> (AirPollutionName,Int){
        let percent = Int((pm2_5 / 75) * 100)
        switch pm2_5 {
        case 0...10:
            return (AirPollutionName.Good,percent)
        case 10...25:
            return (AirPollutionName.Fair,percent)
        case 25...50:
            return (AirPollutionName.Moderate,percent)
        case 50...75:
            return (AirPollutionName.Poor,percent)
        default:
            return (AirPollutionName.Very_Poor,percent)
        }
        
    }
    static func o3Control(o3: Double) -> (AirPollutionName,Int){
        let percent = Int((o3 / 180) * 100)
        switch o3 {
        case 0...60:
            return (AirPollutionName.Good,percent)
        case 60...100:
            return (AirPollutionName.Fair,percent)
        case 100...140:
            return (AirPollutionName.Moderate,percent)
        case 140...180:
            return (AirPollutionName.Poor,percent)
        default:
            return (AirPollutionName.Very_Poor,percent)
        }
        
    }
    static func coControl(co: Double) -> (AirPollutionName,Int){
        let percent = Int((co / 15400) * 100)
        switch co {
        case 0...4400:
            return (AirPollutionName.Good,percent)
        case 4400...9400:
            return (AirPollutionName.Fair,percent)
        case 9400...12400:
            return (AirPollutionName.Moderate,percent)
        case 12400...15400:
            return (AirPollutionName.Poor,percent)
        default:
            return (AirPollutionName.Very_Poor,percent)
        }
        
    }
    
}
