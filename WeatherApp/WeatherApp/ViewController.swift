//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {
 // icon image = https://openweathermap.org/img/wn/"\(iconName)"@2x.png
   
    let httpRequest = HttpRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        httpRequest.getCurrentWeatherData { result, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let result = result {
                print("Weather co: \(result.list.first??.components)")
            }

        }
        
    }


}

