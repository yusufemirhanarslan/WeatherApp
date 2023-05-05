//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 28.04.2023.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController {
    // icon image = https://openweathermap.org/img/wn/"\(iconName)"@2x.png
    
    let sheetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SheetViewController")
    
    let center = UNUserNotificationCenter.current()
    
    @IBOutlet weak var currentLocationName: UILabel!
    
    @IBOutlet weak var notificationSender: UIImageView!
    @IBOutlet weak var weatherStatusView: UIView!
    @IBOutlet weak var currentWeatherDescription: UILabel!
    @IBOutlet weak var currentWeatherDegree: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentForecastView: UIView!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currnetWindState: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    let locationManager = CLLocationManager()
    let httpRequest = HttpRequest()
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        checkLocationServices()
        requestNotification()
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendNotification))
        notificationSender.isUserInteractionEnabled = true
        notificationSender.addGestureRecognizer(tapGestureRecognizer)
        
        forecastViewTapGesture()
    }
    
    func requestNotification() {
        center.requestAuthorization(options: [.badge,.sound,.alert]) { (granted,error) in
            
            if error == nil {
                
                print("User permission granted = \(granted)")
            }
        }
        
    }
    
    @objc func sendNotification() {
        
        //Create the notificaiton content
        let content = UNMutableNotificationContent()
        content.title = "Merhaba Nasılsınız efenim"
        content.body = "Sağolun iyiyim"
        
        center.getDeliveredNotifications { (notifications) in
            
            for notification in notifications {
                print("Delivered notifications Title \(notification.request.content.title)")
            }
            
        }
        
        // Create the notification trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        // Create a request
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        // Register with notification center
        
        center.add(request) { error in
            
            if let error = error {
                        print("Error adding notification request: \(error.localizedDescription)")
                    } else {
                        print("Notification request added successfully")
                    }
            
        }
                 
    }
    
    func formattedDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y HH:mm"
            return formatter.string(from: date)
        }
    
    private func forecastViewTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openSheet))
        currentForecastView.addGestureRecognizer(tapGesture)
    }
    
    @objc func openSheet() {
        
        if let sheet = sheetVC.sheetPresentationController {
            
            sheet.detents = [.medium()]
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
            currentWeatherCase()
        default:
            break
        }
        
    }
    
    
    func currentWeatherCase(){
        
        let lat = findLocation().coordinate.latitude
        let lon = findLocation().coordinate.longitude
        
        httpRequest.getCurrentWeatherData() { result, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            if let result = result {
                
                DispatchQueue.main.async {
                    
                    self.currentLocationName.text = result.name
                    self.currentWeatherDescription.text = result.weather.first??.main
                    
                    if let icon = result.weather.first??.icon {
                        ConfigureImageview.setIconImage(imageView: self.currentWeatherImage, imageString: icon)
                    }
                    
                    
                    self.currentWeatherDegree.text = "\(String(format: "%.1f", (result.main?.temp)! - 272.15))°"
                    
                    if let wind = result.wind?.speed {
                        self.currnetWindState.text = "Wind | \(wind) km/h "
                    }
                    
                    if let humidty = result.main?.humidity {
                        self.currentHumidityLabel.text = "Humidty | % \(humidty) "
                    }
                    
                    if let sunrise = result.sys?.sunrise {
                        self.sunriseLabel.text = self.changeDate(unixTimeStamp: sunrise)
                    }
                    
                    if let sunset = result.sys?.sunset {
                        self.sunsetLabel.text = self.changeDate(unixTimeStamp: sunset)
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    func changeDate(unixTimeStamp: Int) -> String{
        let unixTimestamp = unixTimeStamp
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 10800)
        let formattedTime = dateFormatter.string(from: date)
        
        return formattedTime
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}

