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
    
    let sheetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SheetViewController")
    
    @IBOutlet weak var currentLocationName: UILabel!
    
    @IBOutlet weak var weatherStatusView: UIView!
    @IBOutlet weak var currentWeatherDescription: UILabel!
    @IBOutlet weak var currentWeatherDegree: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentForecastView: UIView!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currnetWindState: UILabel!
    
    let locationManager = CLLocationManager()
    let httpRequest = HttpRequest()
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        checkLocationServices()
    }
    
    
    private func setupView() {
        
        weatherStatusView.layer.cornerRadius = 10
        weatherStatusView.layer.borderWidth = 0.5
        weatherStatusView.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        weatherStatusView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        currentForecastView.layer.cornerRadius = 10
        currentForecastView.layer.borderWidth = 0.5
        currentForecastView.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        currentForecastView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        currentWeatherImage.contentMode = .scaleToFill
        
       
        forecastViewTapGesture()
    }
    
    private func forecastViewTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openSheet))
        currentForecastView.addGestureRecognizer(tapGesture)
    }
    
    @objc func openSheet() {
        
        if let sheet = sheetVC.sheetPresentationController {
            
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
            sheet.largestUndimmedDetentIdentifier = .medium
            
        }
        self.present(sheetVC, animated: true)
        
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
                    
                    self.currentLocationName.text = result.name
                    self.currentWeatherDescription.text = result.weather.first??.main
                    
                    if let icon = result.weather.first??.icon {
                        let image = self.httpRequest.getIconImage(with: icon)
                        self.currentWeatherImage.image = image
                    }
                    
                    self.currentWeatherDegree.text = "\(String(format: "%.1f", (result.main?.temp)! - 272.15))°"
                    
                    if let wind = result.wind?.speed {
                        self.currnetWindState.text = "Wind | \(wind) km/h "
                    }
                    
                    if let humidty = result.main?.humidity {
                        self.currentHumidityLabel.text = "Humidty | % \(humidty) "
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func changeDate() {
        let unixTimestamp = 1000000
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 10800)
        let formattedTime = dateFormatter.string(from: date)
        print(formattedTime)
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}

