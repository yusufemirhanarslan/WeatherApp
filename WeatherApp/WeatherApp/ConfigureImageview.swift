//
//  ConfigureImageview.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 2.05.2023.
//

import Foundation
import UIKit

let httpRequest = HttpRequest()
class ConfigureImageview{
    
    static func setIconImage(imageView: UIImageView, imageString: String) {
        httpRequest.getIconImage(imageString: imageString) { imageData in
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
