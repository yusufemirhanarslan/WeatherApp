//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 28.04.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
 // icon image = https://openweathermap.org/img/wn/"\(iconName)"@2x.png
   
    @IBOutlet weak var scrollView: UIScrollView!
    
    let locationManager = CLLocationManager()
    let httpRequest = HttpRequest()
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkLocationServices()
        setupColors()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            
        }else {
            print("Lütfen izin verin")
        }
        
    }
    
    func findLocation() -> CLLocation {
        
        guard let lon = locationManager.location?.coordinate.longitude else {return CLLocation()}
        guard let lat = locationManager.location?.coordinate.latitude else {return CLLocation()}
        
        return CLLocation(latitude: lat, longitude: lon)
        
    }
    
    func setupColors() {
        let topColor = UIColor.blue.cgColor
        let middleColor = UIColor.orange.cgColor
        let bottomColor = UIColor.red.cgColor
        
        gradientLayer.colors = [topColor,middleColor,gradientLayer]
        
        gradientLayer.locations = [0.0, 1.0, 2.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            return
        case .denied:
            return
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            print("Kullanıcı izin vermiş")
            currentWeatherCase()
        default:
            break
        }
        
    }
    
    
    func currentWeatherCase(){
        
        let lat = findLocation().coordinate.latitude
        let lon = findLocation().coordinate.longitude
        
        httpRequest.getCurrentWeatherData(lat: lat, lon: lon) { result, error in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                if let result = result {
                    
                    DispatchQueue.main.async {
                        
                        let unixTimestamp = result.sys?.sunrise
                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp!))
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        dateFormatter.timeZone = TimeZone(secondsFromGMT: result.timezone!)
                        let formattedTime = dateFormatter.string(from: date)
                        print(formattedTime)
                    }
                    
                }

            }
        
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}

