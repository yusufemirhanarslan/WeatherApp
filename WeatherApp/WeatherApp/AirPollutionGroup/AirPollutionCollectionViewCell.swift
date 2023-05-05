//
//  AirPollutionCollectionViewCell.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 3.05.2023.
//

import UIKit

class AirPollutionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var pollutionGasesPercent: UILabel!
    @IBOutlet weak var pollutionGasesLAbel: UILabel!
    @IBOutlet weak var circleView: UIImageView!
    
    let httpRequest = HttpRequest()
    
    
    func setup(_ indexPath: IndexPath) {
        outView.layer.cornerRadius = 10
        
        let indexPath = indexPath
        
        httpRequest.getAirPollutionData { result, error in
            
            if let error = error {
                
                print("Error = \(String(describing: error.localizedDescription))")
            }
            
            if let result = result {
                
                DispatchQueue.main.async {
                    
                    switch indexPath.row {
                    case 0:
                        self.pollutionGasesLAbel.text = "co";
                        self.pollutionGasesPercent.text = "%\(ControlAirPollution.coControl(co: (result.list[0]?.components?.co)!).1)";
                        self.circleView.image = self.createCircle(percent: Double(ControlAirPollution.coControl(co: (result.list[0]?.components?.co)!).1))
                        
                    case 1:
                        self.pollutionGasesLAbel.text = "so2";
                        self.pollutionGasesPercent.text = "%\(ControlAirPollution.so2Control(so2: (result.list[0]?.components?.so2)!).1)";
                        self.circleView.image = self.createCircle(percent: Double(ControlAirPollution.so2Control(so2: (result.list[0]?.components?.so2)!).1))
                    case 2:
                        self.pollutionGasesLAbel.text = "no2";
                        self.pollutionGasesPercent.text = "%\(ControlAirPollution.no2Control(no2: (result.list[0]?.components?.no2)!).1)";
                        self.circleView.image = self.createCircle(percent: Double(ControlAirPollution.no2Control(no2: (result.list[0]?.components?.no2)!).1))
                    case 3:
                        self.pollutionGasesLAbel.text = "pm10";
                        self.pollutionGasesPercent.text = "%\(ControlAirPollution.pm10Control(pm10: (result.list[0]?.components?.pm10)!).1)";
                        self.circleView.image = self.createCircle(percent: Double(ControlAirPollution.pm10Control(pm10: (result.list[0]?.components?.pm10)!).1))
                    case 4:
                        self.pollutionGasesLAbel.text = "pm2.5";
                        self.pollutionGasesPercent.text = "%\(ControlAirPollution.pm2_5Control(pm2_5: (result.list[0]?.components?.pm2_5)!).1)";
                        self.circleView.image = self.createCircle(percent: Double(ControlAirPollution.pm2_5Control(pm2_5: (result.list[0]?.components?.pm2_5)!).1))
                    case 5:
                        self.pollutionGasesLAbel.text = "03";
                        self.pollutionGasesPercent.text = "%\(ControlAirPollution.o3Control(o3: (result.list[0]?.components?.o3)!).1)";
                        self.circleView.image = self.createCircle(percent: Double(ControlAirPollution.o3Control(o3: (result.list[0]?.components?.o3)!).1))
                    default:
                        break
                        
                    }
                }
            }
            
        }
    }
    
    func createCircle(percent: Double) -> UIImage {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))

        // 0.0 ile 1.0 arasında rastgele bir sayı
        let ratio1 = percent / 100
        let ratio2 = 1 - percent // 1 ve rastgele sayı arasındaki fark

        let img = renderer.image { ctx in

            // %60'lık kısım için turuncu kenar rengi
            ctx.cgContext.setStrokeColor(UIColor.gray.cgColor)
            ctx.cgContext.setLineWidth(5)
            let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
            ctx.cgContext.addArc(center: CGPoint(x: rectangle.midX , y: rectangle.midY ),
                                 radius: rectangle.width/2,
                                 startAngle: -(.pi/2),
                                 endAngle: .pi * ratio1 * 2 - .pi/2,
                                 clockwise: false)
            ctx.cgContext.drawPath(using: .stroke)
                    
            // Geri kalan %40'lık kısım için yeşil kenar rengi
            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            ctx.cgContext.addArc(center: CGPoint(x: rectangle.midX , y: rectangle.midY ),
                                 radius: rectangle.width/2,
                                 startAngle: .pi * ratio1 * 2 - .pi/2,
                                 endAngle: -.pi/2,
                                 clockwise: false)
            ctx.cgContext.drawPath(using: .stroke)
        }
        
        return img
        
    }
}
