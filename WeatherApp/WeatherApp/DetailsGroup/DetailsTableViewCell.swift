//
//  DetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 1.05.2023.
//

import UIKit

class DetailsTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var outView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentDegreeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    let httpRequest = HttpRequest()
  
    func setup(_ indexPath: IndexPath) {
        let indexPath = indexPath
        
        httpRequest.forecastResult { result, error in
            
            if let error = error {
                print(String(describing: error))
            }
            
            if let result = result {
                
                DispatchQueue.main.async {
                    
                    self.currentDegreeLabel.text = String(format: "%.1f", (result.list[indexPath.row]?.main?.temp)! - 272.15 ) + "°"
                    
                    if let icon = result.list[indexPath.row]?.weather.first??.icon {
                        ConfigureImageview.setIconImage(imageView: self.currentWeatherImage, imageString: icon)
                    }
                    
                    self.hourLabel.text = " " + convertDate(result: result, indexPath: indexPath).0 + ":" + convertDate(result: result, indexPath: indexPath).1
                    
                    self.dateLabel.text = " \(convertDay(result: result, indexPath: indexPath).0) " +  convertDay(result: result, indexPath: indexPath).1
                    
                }
                
            }
        }
        outView.layer.cornerRadius = 10
        outView.layer.borderWidth = 0.6
        outView.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
}

private func convertDate(result: ResultForeCast, indexPath: IndexPath) -> (String,String) {
    
    var hourString = String()
    var minuteString =  String()
    
    let calendar = findDate(result: result, indexPath: indexPath).0
    let date = findDate(result: result, indexPath: indexPath).1
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
   
    
    switch hour {
        
    case 1...9:
        hourString = "0\(hour)"
    case 10...24:
        hourString = "\(hour)"
    default:
        hourString = "00"
        
    }
    
    switch minute {
        
    case 1...9:
        minuteString = "0\(minute)"
    case 10...59:
        minuteString = "\(minute)"
    default:
        minuteString = "00"
    }
    
    
    return (hourString,minuteString)
}

func findDate(result: ResultForeCast, indexPath: IndexPath) -> (Calendar,Date) {
    
    var calendar: Calendar!
    var dateConvert: Date!
    let string = result.list[indexPath.row]?.dt_txt
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    if let date = dateFormatter.date(from: string!) {
        calendar = Calendar.current
        dateConvert = date
    }
    
    return (calendar, dateConvert)
}

func convertDay(result: ResultForeCast, indexPath: IndexPath) -> (Int,String) {
    
    let calendar = findDate(result: result, indexPath: indexPath).0
    let date = findDate(result: result, indexPath: indexPath).1
    
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    let monthString = findMonth(month: month)
    return (day,monthString)
}

func findMonth(month: Int) -> String{
    var monthString = ""
    
    switch month {
        
    case 1:
        monthString = "Ocak"
    case 2:
        monthString = "Şubat"
    case 3:
        monthString = "Mart"
    case 4:
        monthString = "Nisan"
    case 5:
        monthString = "Mayıs"
    case 6:
        monthString = "Haziran"
    case 7:
        monthString = "Temmuz"
    case 8:
        monthString = "Ağustos"
    case 9:
        monthString = "Eylül"
    case 10:
        monthString = "Ekim"
    case 11:
        monthString = "Kasım"
    case 12:
        monthString = "Aralık"
    default:
        break
    }
    
    return monthString
    
}
